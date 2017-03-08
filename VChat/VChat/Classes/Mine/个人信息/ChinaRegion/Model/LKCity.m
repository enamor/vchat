//
//  LKCity.m
//  ChinaRegionDemo
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKCity.h"

@implementation LKCity
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"cityName":@"name",
             @"areas":@"sub"
             };
    
}
//+(NSDictionary *)mj_objectClassInArray{
//    return @{
//             @"citys" : @"LKCity",
//             };
//}
@end
