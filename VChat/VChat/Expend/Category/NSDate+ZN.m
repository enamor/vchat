//
//  NSDate+ZN.m
//  fate
//
//  Created by 周恩 on 15/12/26.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import "NSDate+ZN.h"

@implementation NSDate (ZN)
#pragma mark 当前时间
+ (NSString *)currentTime{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"YYYYMMddhhmmss"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    return [[NSString alloc] initWithFormat:@"%@", date];
}

+ (NSString *)currentYear{
    NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
    //[formatter setDateFormat:@"YYYY.MM.dd.hh.mm.ss"];
    [formatter setDateFormat:@"YYYY"];
    NSString *date = [formatter stringFromDate:[NSDate date]];
    return [[NSString alloc] initWithFormat:@"%@", date];
}
@end
