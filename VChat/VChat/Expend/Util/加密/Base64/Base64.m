//
//  Base64.m
//  VChat
//
//  Created by zhouen on 16/8/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "Base64.h"

@implementation Base64
+ (NSString *)encode:(NSData *)data{
    data = [data base64EncodedDataWithOptions:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)decode:(NSString *)str{
    return [[NSData alloc] initWithBase64EncodedString:str options:0];
}



/**
 *  将普通字符串转换成base64字符串
 *  @param text 普通字符串
 *  @return base64字符串
 */
+ (NSString *)base64StringFromText:(NSString *)text {
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    return base64String;
}

/**

 *  将base64字符串转换成普通字符串
 *  @param base64 base64字符串
 *  @return 普通字符串
 */

+ (NSString *)textFromBase64String:(NSString *)base64 {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:0];
    NSString *text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return text;
    
}

@end
