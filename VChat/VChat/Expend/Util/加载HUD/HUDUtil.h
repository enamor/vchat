//
//  HUDUtil.h
//  VChat
//
//  Created by zhouen on 16/8/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HUDUtil : NSObject

+(void)showWithMaskType:(SVProgressHUDMaskType)maskType;

/**
 *  SVProgressHUD 错误提示
 *
 *  @param message  错误描述
 *  @param duration 几秒后消失
 */
+(void)showErrorWithMessage:(NSString *)message duration:(CGFloat)duration;
@end
