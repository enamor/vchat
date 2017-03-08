//
//  ItemModel.h
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ItemAccessoryType) {
    ItemAccessoryTypeNone,
    ItemAccessoryTypeDisclosureIndicator,
    ItemAccessoryTypeSwitch,
    ItemAccessoryTypeCustomView,
};

@interface ItemModel : NSObject
@property (copy,nonatomic)      NSString    *text;
@property (strong,nonatomic)    UIImage     *image;
@property (copy,nonatomic)      NSString    *detailText;
@property (strong,nonatomic)    UIImage     *detailImage;

//type 为ItemAccessoryTypeCustomView 才会生效
@property (strong,nonatomic)    UIView      *customView;
@property (assign,nonatomic)    ItemAccessoryType   accessoryType;

@property (nonatomic,copy) void (^execute)(); /**<      点击item要执行的代码*/
@property (nonatomic,copy) void (^switchValueChanged)(BOOL isOn);
@end
