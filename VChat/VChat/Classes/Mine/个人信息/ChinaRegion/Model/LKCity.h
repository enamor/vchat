//
//  LKCity.h
//  ChinaRegionDemo
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LKCity : NSObject
@property (copy,nonatomic) NSString *cityName;
@property (copy,nonatomic) NSString *zipcode;
@property (strong,nonatomic) NSArray *areas;
@end
