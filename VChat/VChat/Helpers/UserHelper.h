//
//  UserHelper.h
//  VChat
//
//  Created by zhouen on 16/6/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

//
//typedef void( ^ ResponseSuccess)(id response);
//typedef void( ^ ResponseFailure)(id ss);

@class  UserModel;

@interface UserHelper : HttpRequestHelper

/**
 *  用户登录
 *
 *  @param user 用户
 */
-(void)toLoginWithUser:(UserModel *)user success:(ResponseSuccess)success failure:(ResponseFailure)failure;

/**
 *  用户注册
 *
 *  @param user 用户
 */
-(void)toRegisterUser:(UserModel *)user success:(ResponseSuccess)success failure:(ResponseFailure)failure;

/**
 *  上传头像
 *
 *  @param data     data
 *  @param fileName --
 *  @param success  --
 *  @param failure  --
 */
-(void)uploadHeaderImage:(NSData *)data fileName:(NSString *)fileName success:(ResponseSuccess)success failure:(ResponseFailure)failure;

@end
