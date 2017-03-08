//
//  HUDUtil.m
//  VChat
//
//  Created by zhouen on 16/8/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "HUDUtil.h"
#import <UIKit/UIKit.h>

@implementation HUDUtil
+(void)showWithMaskType:(SVProgressHUDMaskType)maskType{
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:maskType];
    
}

+(void)showErrorWithMessage:(NSString *)message duration:(CGFloat)duration{
    [SVProgressHUD showErrorWithStatus:message];
    [SVProgressHUD dismissWithDelay:duration];
}
@end
