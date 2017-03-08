//
//  MD5Util.m
//  AES
//
//  Created by zn on 15/11/20.
//  Copyright © 2015年 zn. All rights reserved.
//

#import "MD5Util.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MD5Util
+(NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
