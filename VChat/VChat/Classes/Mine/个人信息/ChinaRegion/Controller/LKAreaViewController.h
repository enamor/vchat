//
//  LKAreaViewController.h
//  ChinaRegionDemo
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LKProvince,LKCity;
@interface LKAreaViewController : UITableViewController
@property (weak,nonatomic) LKProvince *province;
@property (weak,nonatomic) LKCity *city;
@end
