//
//  AESUtil.h
//  VChat
//
//  Created by zhouen on 16/8/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AESUtil : NSObject
/**
 *  AES-128-ECB加密模式，key需要为16位 PKCS5Padding
 *
 *  @param content 需要加密的内容
 *  @param key     加密用的key
 *
 *  @return 加密后的base64字符
 */
+ (NSString *)encode:(NSString *)content key:(NSString *)key;

/**
 *  解密
 *
 *  @param content 加密过的字符
 *  @param key     解密用的key
 *
 *  @return 解密后的字符
 */
+ (NSString *)decode:(NSString *)content key:(NSString *)key;
@end
