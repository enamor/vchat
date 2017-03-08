//
//  AppDelegate.h
//  VChat
//
//  Created by zhouen on 16/5/6.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
#import "TabBarViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,EMCallManagerDelegate,EMClientDelegate,EMChatManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

