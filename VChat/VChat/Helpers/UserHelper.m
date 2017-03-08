//
//  UserHelper.m
//  VChat
//
//  Created by zhouen on 16/6/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "UserHelper.h"
#import "UserModel.h"
#import "RSAUtil.h"
#import "HUDUtil.h"

static NSString *AESKey = @"+QSx7MZ6R1MnEg==";

static UserHelper *helper = nil;
@implementation UserHelper

+ (instancetype)shareHelper
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[UserHelper alloc] init];
    });
    return helper;
}

#pragma mark 用户登录
-(void)toLoginWithUser:(UserModel *)user success:(ResponseSuccess)success failure:(ResponseFailure)failure{
    user.AESKey = AESKey;
    NSDictionary *userDict = [user descriptionDictionary];
    if (!userDict) {
        if (failure)
            failure(nil);
        [HUDUtil showErrorWithMessage:@"用户信息有误" duration:2.0];
    }
    NSString *RSAStr = [RSAUtil encryptDict:userDict publicKey:kLuckRSAPublicKey];
    NSDictionary *userInfo = @{@"userInfo":RSAStr};
    [HUDUtil showWithMaskType:SVProgressHUDMaskTypeBlack];
    [self postRequestWithURL:@"/user/toLogin" parameters:userInfo success:^(id response) {
        int code = [response[@"code"] intValue];
        NSString *message = response[@"message"];
        if (code == 200) {
            if (success)
                success(response[@"data"]);
        }else{
            if (failure)
                failure(nil);
            [HUDUtil showErrorWithMessage:message duration:2.0];
        }
 
    } failure:^(NSError *error) {
        if (failure)
            failure(nil);
        [HUDUtil showErrorWithMessage:@"请求失败" duration:2.0];
    }];
}

#pragma mark 用户注册
-(void)toRegisterUser:(UserModel *)user success:(ResponseSuccess)success failure:(ResponseFailure)failure{
    user.AESKey = AESKey;
    NSDictionary *userDict = [user descriptionDictionary];
    if (!userDict) {
        NSLog(@"用户信息有误");
    }
    NSString *RSAStr = [RSAUtil encryptDict:userDict publicKey:kLuckRSAPublicKey];
    NSDictionary *userInfo = @{@"userInfo":RSAStr};
    [self postRequestWithURL:@"/user/toRegister" parameters:userInfo success:^(id response) {
        int code = [response[@"code"] intValue];
        NSString *message = response[@"message"];
        if (code == 200) {
            if (success)
                success(response[@"data"]);
        }else{
            if (failure)
                failure(nil);
            
            [HUDUtil showErrorWithMessage:message duration:2.0];
        }
        
    } failure:^(NSError *error) {
        if (failure)
            failure(nil);
        [HUDUtil showErrorWithMessage:@"请求失败" duration:2.0];
    }];

}

#pragma mark 上传头像
-(void)uploadHeaderImage:(NSData *)data fileName:(NSString *)fileName success:(ResponseSuccess)success failure:(ResponseFailure)failure{
    
    [self uploadWithURL:@"/user/toUploadAvatar" data:data name:@"images" fileName:fileName params:nil success:^(NSDictionary *result) {
        int code = [result[@"code"] intValue];
        NSString *message = result[@"message"];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (code == 200) {
                if (success) {
                    success(result[@"data"]);
                }
            }else{
                if (failure) {
                    failure(message);
                }
                
            }
        });
        
    } failure:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failure) {
                failure(error.localizedFailureReason);
            }
        });
    }];
}

@end
