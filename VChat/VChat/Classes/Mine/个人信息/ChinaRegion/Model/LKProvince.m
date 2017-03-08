//
//  LKProvince.m
//  ChinaRegionDemo
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKProvince.h"
#import "MJExtension.h"
#import "LKCity.h"
@implementation LKProvince
+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"provinceName":@"name",
             @"citys":@"sub"
             };
    
}
+(NSDictionary *)mj_objectClassInArray{
    return @{
             @"citys" : @"LKCity",
             };
}
@end
