//
//  VideoChatHelper.h
//  VChat
//
//  Created by zhouen on 16/5/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CallViewController.h"

@interface VideoChatHelper : NSObject <EMClientDelegate,EMChatManagerDelegate,EMContactManagerDelegate,EMGroupManagerDelegate,EMChatroomManagerDelegate>


@property (weak,nonatomic) UIViewController *mainVC;
@property (strong, nonatomic) EMCallSession *callSession;
@property (strong, nonatomic) CallViewController *callController;

@property (assign,nonatomic) BOOL isInLuckRoom;


//视频通道建立完成 （用户 A、B都会收到）
@property (copy,nonatomic) void(^channelFinished)();

/**
 *  应答成功
 */
@property (copy,nonatomic) void(^answerCallBlock)();

/**
 *  收到视频请求
 */
@property (copy,nonatomic) void(^receivedCallBlock)();

/**
 *  被动挂断
 */
@property (copy,nonatomic) void(^failedCallBlock)();

/**
 *  主动挂断
 */
@property (copy,nonatomic) void(^hangupCallBlock)();

+ (instancetype)shareHelper;

-(void)makeVideoCall:(NSString *)userName callSession:(void (^)(EMCallSession *callSession))callBack;

- (void)answerCall;
- (void)hangupCall;

-(void)clearBlock;

@end


