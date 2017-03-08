//
//  LKGlobalUser.h
//  VChat
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKGlobalUser : NSObject<NSCoding>
+ (LKGlobalUser *)shareInstance;
-(void)updateGlobalUserByDict:(NSDictionary *)dict;
-(void)clearGlobalUser;

@property (assign,nonatomic)    long        uid;
@property (copy,nonatomic)      NSString    *token;
@property (copy,nonatomic)      NSString    *nickName;
@property (copy,nonatomic)      NSString    *headThumb;     //头像缩略图
@property (assign,nonatomic)    NSInteger   sex;            //性别 0男，1女
@property (copy,nonatomic)      NSString    *birthday;      //生日
@property (copy,nonatomic)      NSString    *province;      //省份
@property (copy,nonatomic)      NSString    *city;          //市
@property (copy,nonatomic)      NSString    *area;          //区
@property (copy,nonatomic)      NSString    *signature;     //签名

@end
