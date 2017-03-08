//
//  RandomUtil.m
//  AES
//
//  Created by zn on 15/11/20.
//  Copyright © 2015年 zn. All rights reserved.
//

#import "RandomUtil.h"

@implementation RandomUtil

#pragma mark 随机字符串
+(NSString *)randomCharacters:(NSInteger)length
{
    char data[length];
    //(char)('A' + (arc4random_uniform(26))) //大写的26个字母
    for (int x=0;x< length;data[x++] = (char)('!' + (arc4random_uniform(90))));
    
    return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
    
}
@end
