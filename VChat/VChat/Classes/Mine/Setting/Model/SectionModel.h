//
//  SectionModel.h
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface SectionModel : NSObject
@property (copy,nonatomic)      NSString    *headerName;
@property (assign,nonatomic)    CGFloat     headerHeight;
@property (strong,nonatomic)    UIColor     *headerColor;
@property (strong,nonatomic)    NSArray     *items;
@end
