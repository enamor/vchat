//
//  CallViewController.m
//  VChat
//
//  Created by zhouen on 16/5/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "CallViewController.h"
#import "VideoChatHelper.h"
@interface CallViewController ()
{
    BOOL _isCaller;
    NSTimer *_timeTimer;
    NSString *_status;
    int _timeLength;
    
    NSString * _audioCategory;
}

@end
@implementation CallViewController
- (instancetype)initWithSession:(EMCallSession *)session
                       isCaller:(BOOL)isCaller
                         status:(NSString *)statusString
{
    self = [super init];
    if (self) {
        _callSession = session;
        _isCaller = isCaller;
        _timeLabel.text = @"";
        _timeLength = 0;
        _status = statusString;
    }
    
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self _initializeVideoView];
}
- (void)_initializeVideoView
{
    //1.对方窗口
//    _callSession.remoteView = [[EMCallRemoteView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
//    [self.view addSubview:_callSession.remoteView];
    
    //2.自己窗口
    CGFloat width = 80;
    CGFloat height = self.view.frame.size.height / self.view.frame.size.width * width;
//    _callSession.localView = [[EMCallLocalView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 90, CGRectGetMaxY(_statusLabel.frame), width, height)];
//    [self.view addSubview:_callSession.localView];
    
}
- (void)answerAction
{
    [self _stopRing];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    _audioCategory = audioSession.category;
    if(![_audioCategory isEqualToString:AVAudioSessionCategoryPlayAndRecord]){
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [audioSession setActive:YES error:nil];
    }
    [[VideoChatHelper shareHelper] answerCall];

}


#pragma mark - private

- (void)_beginRing
{
    [_ringPlayer stop];
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"callRing" ofType:@"mp3"];
    NSURL *url = [[NSURL alloc] initFileURLWithPath:musicPath];
    
    _ringPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_ringPlayer setVolume:1];
    _ringPlayer.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
    if([_ringPlayer prepareToPlay])
    {
        [_ringPlayer play]; //播放
    }
}

- (void)_stopRing
{
    [_ringPlayer stop];
}

- (void)timeTimerAction:(id)sender
{
    _timeLength += 1;
    int hour = _timeLength / 3600;
    int m = (_timeLength - hour * 3600) / 60;
    int s = _timeLength - hour * 3600 - m * 60;
    
    if (hour > 0) {
        _timeLabel.text = [NSString stringWithFormat:@"%i:%i:%i", hour, m, s];
    }
    else if(m > 0){
        _timeLabel.text = [NSString stringWithFormat:@"%i:%i", m, s];
    }
    else{
        _timeLabel.text = [NSString stringWithFormat:@"00:%i", s];
    }
}



#pragma mark - public

+ (BOOL)canVideo
{
    if([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending){
        if(!([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized)){\
            UIAlertView * alt = [[UIAlertView alloc] initWithTitle:@"No camera permissions" message:@"Please open in \"Setting\"-\"Privacy\"-\"Camera\"." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alt show];
            return NO;
        }
    }
    
    return YES;
}

- (void)startTimer
{
    _timeLength = 0;
    _timeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeTimerAction:) userInfo:nil repeats:YES];
}

- (void)close
{
//    _callSession.remoteView.hidden = YES;
//    _callSession.localView.hidden = YES;
    _callSession = nil;
//    _propertyView = nil;
    
    if (_timeTimer) {
        [_timeTimer invalidate];
        _timeTimer = nil;
    }
    
//    if (_propertyTimer) {
//        [_propertyTimer invalidate];
//        _propertyTimer = nil;
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CALL object:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[AVAudioSession sharedInstance] setActive:NO error:nil];
        [self dismissViewControllerAnimated:NO completion:nil];
    });
}

@end
