//
//  RSAUtil.h
//  AES
//
//  Created by zn on 15/11/20.
//  Copyright © 2015年 zn. All rights reserved.
//  @link: https://github.com/ideawu/Objective-C-RSA


#import <Foundation/Foundation.h>

@interface RSAUtil : NSObject
/*****************begin*************/

// 一般 公钥加密私钥解密

// 公钥加密
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSString *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)encryptDict:(NSDictionary *)dict publicKey:(NSString *)pubKey;

// 私钥解密
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptBase64String:(NSString *)data privateKey:(NSString *)privKey;
/*****************end*************/



@end
