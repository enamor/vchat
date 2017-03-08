//
//  CallViewController.h
//  VChat
//
//  Created by zhouen on 16/5/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface CallViewController : BaseViewController
{
    AVAudioPlayer *_ringPlayer;
}
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UILabel *timeLabel;
@property (weak,nonatomic)  __weak EMCallSession *callSession;

- (instancetype)initWithSession:(EMCallSession *)session
                       isCaller:(BOOL)isCaller
                         status:(NSString *)statusString;

+ (BOOL)canVideo;

- (void)startTimer;

- (void)close;

- (void)answerAction;
@end
