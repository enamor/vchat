//
//  CallView.m
//  VChat
//
//  Created by zhouen on 16/7/6.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "CallView.h"
#import <AVFoundation/AVFoundation.h>
@interface CallView ()
@property (nonatomic) AVCaptureSession *captureSession;

@property (strong,nonatomic) UIImageView    *headImage;
@property (strong,nonatomic) UILabel        *nickName;
@property (strong,nonatomic) UILabel        *describeLabel;

@property (strong,nonatomic) UIView         *bottomView;
@property (strong,nonatomic) UIButton       *hangUpBtn;     //挂断
@property (strong,nonatomic) UIButton       *cutInBtn;      //接听
@end
@implementation CallView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview{
    CGFloat headWH = 80;
    CGFloat headX = (kLuckScreenWidth - headWH)/2.0;
    CGFloat headY = 100;
    self.headImage = [[UIImageView alloc] initWithFrame:CGRectMake(headX, -headWH, headWH, headWH)];
    [self addSubview:_headImage];
    _headImage.layer.cornerRadius = headWH/2.0;
    _headImage.layer.masksToBounds = YES;
    _headImage.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    _headImage.layer.borderWidth = 5.0;
    
    //昵称
    self.nickName = [[UILabel alloc] initWithFrame:CGRectMake(0, headY+headWH, self.width, 30)];
    _nickName.textColor = [UIColor whiteColor];
    _nickName.textAlignment = NSTextAlignmentCenter;
    _nickName.font = [UIFont systemFontOfSize:15];
    _nickName.text = @"哈哈哈哈哈";
    _nickName.alpha = 0.0;
    [self addSubview:_nickName];
    
    //描述
    self.describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _nickName.bottom, self.width, 30)];
    _describeLabel.text = @"妹子正在路上";
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    _describeLabel.font = [UIFont systemFontOfSize:15];
    _describeLabel.textColor = [UIColor whiteColor];
    _describeLabel.alpha = 0.0;
    [self addSubview:_describeLabel];
    
    //底部
    CGFloat bottomH = self.height/3.0;
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, bottomH)];
    [self addSubview:_bottomView];
    
    //挂断
    CGFloat margin = 80;
    CGFloat btW = 100;
    CGFloat btH = 40;
    CGFloat btY = bottomH - 140;
    if (isIphone4 || isIPhone5) {
        margin = 60;
        btW = 80;
        btH = 30;
    }
    
    CGFloat btX = self.width/2.0 - margin/2.0 - btW;
    UIButton *hangupBtn = [[UIButton alloc] initWithFrame:CGRectMake(btX, btY, btW, btH)];
    [_bottomView addSubview:hangupBtn];
    self.hangUpBtn = hangupBtn;
    hangupBtn.backgroundColor = [UIColor redColor];
    hangupBtn.layer.cornerRadius = 6.0;
    hangupBtn.layer.masksToBounds = YES;
    [hangupBtn setTitle:@"挂断" forState:UIControlStateNormal];
    
    //接听
    UIButton *cutinBtn = [[UIButton alloc] initWithFrame:CGRectMake(_hangUpBtn.right +margin, btY, btW, btH)];
    [_bottomView addSubview:cutinBtn];
    self.cutInBtn = cutinBtn;
    cutinBtn.layer.cornerRadius = 6.0;
    cutinBtn.layer.masksToBounds = YES;
    cutinBtn.backgroundColor = [UIColor greenColor];
    [cutinBtn setTitle:@"邂逅" forState:UIControlStateNormal];
    
    
}

- (BOOL)startReading
{
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDeviceInput *videoInput =[[AVCaptureDeviceInput alloc] initWithDevice:[self frontCamera] error:&error];
    if (!videoInput) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    // 创建会话
    _captureSession = [[AVCaptureSession alloc] init];
    // 添加输入流
    [_captureSession addInput:videoInput];
    
    //实例化预览图层(输出对象)
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    
    //设置预览图层填充方式
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    
    layer.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [self.layer insertSublayer:layer atIndex:0];
    
    //开始捕获
    [_captureSession startRunning];
    return YES;
}
- (void)stopReading
{
    // 停止会话
    [_captureSession stopRunning];
    _captureSession = nil;
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if ([device position] == position) {
            return device;
        }
    }
    return nil;
}

- (AVCaptureDevice *)frontCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionFront];
}


- (AVCaptureDevice *)backCamera {
    return [self cameraWithPosition:AVCaptureDevicePositionBack];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

-(void)beginToCall{
    [self hiddenWidget:NO];
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.bottom = self.height;
        _headImage.top = 100;
        _nickName.alpha = 1.0;
        _describeLabel.alpha = 1.0;
        
    }];
}

-(void)backOriginalState{
    [UIView animateWithDuration:0.5 animations:^{
        _bottomView.top = self.height;
        _headImage.bottom = 0;
        _nickName.alpha = 0.0;
        _describeLabel.alpha = 0.0;
        
    }completion:^(BOOL finished) {
        [self hiddenWidget:YES];
    }];
}

-(void)hiddenWidget:(BOOL)isHidden{
    _bottomView.hidden = isHidden;
    _headImage.hidden = isHidden;
    _nickName.hidden = isHidden;
    _describeLabel.hidden = isHidden;
}
@end
