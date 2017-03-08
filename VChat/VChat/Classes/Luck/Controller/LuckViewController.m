//
//  LuckViewController.m
//  VChat
//
//  Created by zhouen on 16/5/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LuckViewController.h"
#import "VideoChatHelper.h"
#import "UIView+Animation.h"
#import "UIImage+BlurEffect.h"
#import "CallView.h"
static NSString *reuseIdentifier = @"callcell";
@interface LuckViewController ()
{
    NSTimer *_callTimer;
}
@property (strong, nonatomic) EMConversation    *conversation;
@property (weak,nonatomic) VideoChatHelper      *videoChatHelper;
@property (strong,nonatomic) CallView           *callView;          //打电话view
@property (strong,nonatomic) UIImageView        *bgView;            //毛玻璃背景

@property (strong,nonatomic) EMCallRemoteView   *remoteView;        //对方视频窗口
@property (strong,nonatomic) EMCallLocalView    *localView;         //自己视频窗口


@property (strong,nonatomic) UIButton           *closeBtn;//关闭按钮
@end
@implementation LuckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self _setupSubview];
//    //建立视频通道回调
//    [self _setupVideoHelperBlock];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

-(void)_setupVideoHelperBlock{
    _videoChatHelper = [VideoChatHelper shareHelper];
    _videoChatHelper.isInLuckRoom = YES;
    _videoChatHelper.answerCallBlock = ^{
        NSLog(@"已经建立通话连接");
        
    };
    _videoChatHelper.failedCallBlock = ^{
        NSLog(@"通话连接失败");
        self.callSession = nil;
    };
    _videoChatHelper.receivedCallBlock = ^{
        NSLog(@"接收到通话请求");
    };
    _videoChatHelper.hangupCallBlock = ^{
        NSLog(@"挂断");
    };
    _videoChatHelper.channelFinished = ^{
        NSLog(@"通道建立完成");
        [_callView backOriginalState];
        [self establishVideoView];
    };
}

-(void)_setupSubview{
    //自己的视频窗口
    self.callView = [[CallView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_callView];
    [_callView startReading];
    
    //对方视频窗口
    _remoteView = [[EMCallRemoteView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    _remoteView.hidden = YES;
    [self.view insertSubview:_remoteView belowSubview:_callView];
    
    //自己视频窗口
    _localView = [[EMCallLocalView alloc] initWithFrame:CGRectMake(self.view.width - 150, 0, 150, 200)];
    _localView.hidden = YES;
    [self.view insertSubview:_localView belowSubview:_callView];
    
    //关闭按钮
    _closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(kLuckScreenWidth - 100, kLuckScreenHeight - 50, 100, 40)];
    _closeBtn.backgroundColor = [UIColor grayColor];
    [_closeBtn setTitle:@"close" forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(hangupCall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_closeBtn];
    
    
#warning 测试按钮
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 80, 40)];
    button.backgroundColor = [UIColor grayColor];
    [button addTarget:self action:@selector(establishRandomVideoChannel) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}

#pragma mark 建立随机视频通道
-(void)establishRandomVideoChannel{
    [self.callView beginToCall];
    
    __unsafe_unretained typeof(self) weakSelf = self;
    [_videoChatHelper makeVideoCall:@"test1" callSession:^(EMCallSession *callSession) {
        weakSelf.callSession  = callSession;
//        _callSession.remoteView = _remoteView;
//        _callSession.localView = _localView;
    }];
}


#pragma mark 视频聊天控件的隐藏与显示
-(void)changeChatViewHiddenState:(BOOL)isHidden{
    _localView.hidden = isHidden;
    _remoteView.hidden = isHidden;
}

-(void)establishVideoView{
    if (_callSession) {
        [_callView stopReading];
        //1.对方窗口
        [self changeChatViewHiddenState:NO];
        
    }
}
- (void)hangupCall{
    [self changeChatViewHiddenState:YES];
    [_videoChatHelper hangupCall];
}





@end
