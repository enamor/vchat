//
//  UserModel.h
//  VChat
//
//  Created by zhouen on 16/6/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    AccountTypeTel = 0,
    AccountTypeQQ ,
    AccountTypeWeiChat,
    AccountTypeWeiBo
}AccountType;
@interface UserModel : NSObject
@property (copy,nonatomic) NSString     *account;
@property (copy,nonatomic) NSString     *password;
@property (copy,nonatomic) NSString     *nickname;
@property (copy,nonatomic) NSString     *token;
@property (copy,nonatomic) NSString     *AESKey;
@property (assign,nonatomic) AccountType  accountType;         //0 手机号登录、1 QQ登录、2 微信登录 、3 微博登录

-(NSDictionary *)descriptionDictionary;
@end
