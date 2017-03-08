//
//  BaseNavigationController.m
//  fate
//
//  Created by 周恩 on 15/10/29.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIImage+Extension.h"
@implementation BaseNavigationController
/**
 *  第一次使用这个类的时候会调用(1个类只会调用1次)
 */
+ (void)initialize
{
    // 1.设置导航栏主题
//    [self setupNavBarTheme];
}

//此方法 UINavigationBar 将影响整个项目中所有的 UINavigationController
+(void)setupNavBarTheme{
    //状态来字体颜色为白色iOS7
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
//    
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
//
//    //背景色
//    navBar.barTintColor = kLuckWhiteColor;
//    //返回箭头的颜色
    navBar.tintColor = [UIColor whiteColor];
//
//    //标题颜色及大小
//    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:kLuckNavBarTitleFont}];
//    
//    //设置成yes的时候 半透明 iOS7
    navBar.translucent = YES;
//
    //去掉下方分界线
    [navBar setBackgroundImage:[UIImage imageWithColor:kLuckThemeColor size:CGSizeMake(kLuckScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationBar.tintColor = [UIColor whiteColor];

    //设置成yes的时候 半透明 iOS7
    self.navigationBar.translucent = NO;
    //
    //去掉下方分界线
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:kLuckThemeColor size:CGSizeMake(kLuckScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewDidLoad{
    [super viewDidLoad];
}


//状态来字体颜色为白色 iOS9
//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    //also you may add any fancy condition-based code here
//    return UIStatusBarStyleLightContent;
//}
@end
