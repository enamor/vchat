
 //
//  VideoChatHelper.m
//  VChat
//
//  Created by zhouen on 16/5/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "VideoChatHelper.h"
@interface VideoChatHelper ()<EMCallManagerDelegate>
{
    NSTimer *_callTimer;
}
@end

static VideoChatHelper *helper = nil;
@implementation VideoChatHelper

+ (instancetype)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[VideoChatHelper alloc] init];
    });
    return helper;
}

- (void)dealloc
{
    [[EMClient sharedClient] removeDelegate:self];
    [[EMClient sharedClient].callManager removeDelegate:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self initHelper];
    }
    return self;
}

- (void)initHelper
{
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].callManager addDelegate:self delegateQueue:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeCall:) name:KNOTIFICATION_CALL object:nil];
}


#pragma mark 拨打视频电话
-(void)makeVideoCall:(NSString *)userName callSession:(void (^)(EMCallSession *callSession))callBack{
    if (!userName) return;
    _callSession = [[EMClient sharedClient].callManager makeVideoCall:userName error:nil];
    if(_callSession && callBack){
        [self _startCallTimer];
        callBack(_callSession);
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"call.initFailed", @"Establish call failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark - EMCallManagerDelegate
//  用户A拨打用户B，用户B会收到这个回调
- (void)didReceiveCallIncoming:(EMCallSession *)aSession
{
    if(_callSession && _callSession.status != EMCallSessionStatusDisconnected){
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonBusy];
    }
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    
    _callSession = aSession;
    if(_callSession){
        [self _startCallTimer];
        if (_isInLuckRoom) {
            if (_receivedCallBlock) {
                _receivedCallBlock();
            }
        }else{
            _callController = [[CallViewController alloc] initWithSession:_callSession isCaller:NO status:NSLocalizedString(@"call.finished", "Establish call finished")];
            _callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [_mainVC presentViewController:_callController animated:NO completion:^{
                [_callController answerAction];
            }];
        }
    }
}

// 通话通道建立完成，用户A和用户B都会收到这个回调
- (void)didReceiveCallConnected:(EMCallSession *)aSession
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [audioSession setActive:YES error:nil];
        
        if (_channelFinished) {
            _channelFinished();
        }
        _callController.statusLabel.text = NSLocalizedString(@"call.finished", "Establish call finished");
    }
}

// 用户B同意用户A拨打的通话后，用户A会收到这个回调
- (void)didReceiveCallAccepted:(EMCallSession *)aSession
{
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive) {
        [[EMClient sharedClient].callManager endCall:aSession.sessionId reason:EMCallEndReasonFailed];
    }
    
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        [self _stopCallTimer];
        
        NSString *connectStr = aSession.connectType == EMCallConnectTypeRelay ? @"Relay" : @"Direct";
        _callController.statusLabel.text = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"call.speak", @"Can speak..."), connectStr];
        _callController.timeLabel.hidden = NO;
        [_callController startTimer];
        
        
//        _callController.cancelButton.hidden = NO;
//        _callController.rejectButton.hidden = YES;
//        _callController.answerButton.hidden = YES;
    }
}

// 用户A或用户B结束通话后，对方会收到该回调
// 通话出现错误，双方都会收到该回调
- (void)didReceiveCallTerminated:(EMCallSession *)aSession
                          reason:(EMCallEndReason)aReason
                           error:(EMError *)aError
{
    if ([aSession.sessionId isEqualToString:_callSession.sessionId]) {
        [self _stopCallTimer];
        
        _callSession = nil;
        
        [_callController close];
        _callController = nil;
        
        if (aReason != EMCallEndReasonHangup) {
            if (_failedCallBlock) {
                _failedCallBlock();
            }
            
//            NSString *reasonStr = @"";
//            switch (aReason) {
//                case EMCallEndReasonNoResponse:
//                {
//                    reasonStr = NSLocalizedString(@"call.noResponse", @"NO response");
//                }
//                    break;
//                case EMCallEndReasonDecline:
//                {
//                    reasonStr = NSLocalizedString(@"call.rejected", @"Reject the call");
//                }
//                    break;
//                case EMCallEndReasonBusy:
//                {
//                    reasonStr = NSLocalizedString(@"call.in", @"In the call...");
//                }
//                    break;
//                case EMCallEndReasonFailed:
//                {
//                    reasonStr = NSLocalizedString(@"call.connectFailed", @"Connect failed");
//                }
//                    break;
//                default:
//                    break;
//            }
//            
//            if (aError) {
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:aError.errorDescription delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//                [alertView show];
//            }
//            else{
//                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:reasonStr delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//                [alertView show];
//            }
        }else{
            if (_hangupCallBlock) {
                _hangupCallBlock();
            }
        }
    }
}


- (void)makeCall:(NSNotification*)notify
{
    if (notify.object) {
        [self makeCallWithUsername:[notify.object valueForKey:@"chatter"] isVideo:[[notify.object objectForKey:@"type"] boolValue]];
    }
}

- (void)_startCallTimer
{
    _callTimer = [NSTimer scheduledTimerWithTimeInterval:60
                                                  target:self selector:@selector(_cancelCall) userInfo:nil repeats:NO];
}

- (void)_stopCallTimer
{
    if (_callTimer == nil) {
        return;
    }
    
    [_callTimer invalidate];
    _callTimer = nil;
}

- (void)_cancelCall
{
    [self hangupCallWithReason:EMCallEndReasonNoResponse];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"call.autoHangup", @"No response and Hang up") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)makeCallWithUsername:(NSString *)aUsername
                     isVideo:(BOOL)aIsVideo
{
    if ([aUsername length] == 0) {
        return;
    }
    
    if (aIsVideo) {
        _callSession = [[EMClient sharedClient].callManager makeVideoCall:aUsername error:nil];
    }
    else{
        _callSession = [[EMClient sharedClient].callManager makeVoiceCall:aUsername error:nil];
    }
    
    if(_callSession){
        [self _startCallTimer];
        _callController = [[CallViewController alloc] initWithSession:_callSession isCaller:YES status:NSLocalizedString(@"call.connecting", @"Connecting...")];
                _callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//                AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//                [delegate.navigationController presentViewController:_callController animated:NO completion:nil];
        [_mainVC presentViewController:_callController animated:NO completion:nil];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"call.initFailed", @"Establish call failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
        [alertView show];
    }
    
}


//挂断
- (void)hangupCall
{
    [self hangupCallWithReason:EMCallEndReasonHangup];
    
}
- (void)hangupCallWithReason:(EMCallEndReason)aReason{
    [self _stopCallTimer];
    if (_callSession) {
        [[EMClient sharedClient].callManager endCall:_callSession.sessionId reason:aReason];
    }
    _callSession = nil;
}

- (void)answerCall
{
//    if (_callSession) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            EMError *error = [[EMClient sharedClient].callManager answerCall:_callSession.sessionId];
//            if (error) {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (error.code == EMErrorNetworkUnavailable) {
//                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"network.disconnection", @"Network disconnection") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//                        [alertView show];
//                    }
//                    else{
//                        [self hangupCallWithReason:EMCallEndReasonFailed];
//                    }
//                });
//            }else{
//                if (_answerCallBlock) {
//                    _answerCallBlock();
//                }
//            }
//        });
//    }
}

#pragma mark - private
- (BOOL)_needShowNotification:(NSString *)fromChatter
{
    BOOL ret = YES;
    NSArray *igGroupIds = [[EMClient sharedClient].groupManager getAllIgnoredGroupIds];
    for (NSString *str in igGroupIds) {
        if ([str isEqualToString:fromChatter]) {
            ret = NO;
            break;
        }
    }
    return ret;
}


- (void)didLoginFromOtherDevice
{
    [self _clearHelper];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginAtOtherDevice", @"your login account has been in other places") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}

- (void)didRemovedFromServer
{
    [self _clearHelper];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"prompt", @"Prompt") message:NSLocalizedString(@"loginUserRemoveFromServer", @"your account has been removed from the server side") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@NO];
}
- (void)_clearHelper
{
    self.mainVC = nil;
    
    [[EMClient sharedClient] logout:NO];
//    [self hangupCallWithReason:EMCallEndReasonFailed];
    [self hangupCallWithReason:EMCallEndReasonHangup];
    
}

-(void)clearBlock{
    _answerCallBlock = nil;
    _hangupCallBlock = nil;
}






@end
