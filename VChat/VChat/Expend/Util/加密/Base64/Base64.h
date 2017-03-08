//
//  Base64.h
//  VChat
//
//  Created by zhouen on 16/8/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+ (NSString *)encode:(NSData *)data;
+ (NSData *)decode:(NSString *)data;

@end
