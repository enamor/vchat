//
//  Macro.h
//  fate
//
//  Created by 周恩 on 15/10/26.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

/*********************颜色相关的宏定义 begin***********************/
//十六进制颜色
#define UIColorFrom0xRGBA(rgbValue ,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define UIColorFrom0xRGB(rgbValue) UIColorFrom0xRGBA(rgbValue,1.0)

#define HEX_COLOR(rgbValue) UIColorFrom0xRGBA(rgbValue,1.0)

// 获取RGB颜色
#define UIColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define UIColorFromRGB(r,g,b) RGBA(r,g,b,1.0f)

//项目全局背景颜色
#define kLuckBackgroundColor  UIColorFrom0xRGB(0xededed)

//navbar barTintColor
#define kLuckNavBarTintColor  UIColorFrom0xRGB(0xCD69C9)

//主题颜色
#define kLuckThemeColor  UIColorFrom0xRGB(0xFF82AB)

//登录注册注销 等按钮颜色
#define kLuckButtonThemeColor  UIColorFrom0xRGB(0xFF82AB)

#define kLuckButtonShallowColor  UIColorFrom0xRGB(0xFFB6C1)

//主题颜色
#define kLuckButtonDefaultColor  UIColorFrom0xRGB(0x319CFF)

//白色
#define kLuckWhiteColor [UIColor whiteColor]
//clearcolor
#define kLuckClearColor [UIColor clearColor];
/*********************颜色相关的宏定义 end***********************/


#define isIphone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIphone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define isIphone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1920, 1080), [[UIScreen mainScreen] currentMode].size) ) : NO)




/*********************尺寸相关的宏定义 begin***********************/
//屏幕宽高
#define kLuckScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kLuckScreenHeight ([UIScreen mainScreen].bounds.size.height)
//状态栏高度
#define kLuckStatusHeight  ([UIApplication sharedApplication].statusBarFrame.size.height)
//状态栏＋导航栏高度
#define kLuckNavStatusHeight (44 + kLuckStatusHeight)
//除去状态栏 导航栏 tabbar的高度
#define kLuckCenterViewHeight (kLuckScreenHeight - kLuckNavStatusHeight)
//除去状态栏 导航栏的高度
#define kLuckCenterViewHeightContainsTabbar (kLuckScreenHeight - kLuckNavStatusHeight)


/*********************尺寸相关的宏定义 end***********************/



/*********************字体大小相关的宏定义 begin***********************/
#define kLuckTabBarItemFont [UIFont systemFontOfSize:10]

//导航栏标题字体大小
#define kLuckNavBarTitleFont [UIFont systemFontOfSize:16]

//一级字体
#define kLuckNormalFont [UIFont systemFontOfSize:15]
//二级字体
#define kLuckNormalTinyFont [UIFont systemFontOfSize:13]

//标注字体 三级字体
#define kLuckNoteFont [UIFont systemFontOfSize:12]
/*********************字体大小相关的宏定义 end***********************/




/*********************手机系统相关的宏定义 begin***********************/
#define kLuckSystemVersion [[UIDevice currentDevice].systemVersion floatValue]
/*********************手机系统相关的宏定义 end***********************/



/*********************RSA公钥 begin***********************/
#define kLuckRSAPublicKey [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rsa_public_key" ofType:@".pem"] encoding:NSUTF8StringEncoding error:nil]
/*********************RSA公钥 end***********************/

#define kLuckRSAPrivateKey [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"rsa_private_key" ofType:@".pem"] encoding:NSUTF8StringEncoding error:nil]


/*
 判断为空
 */
#define isNil(array) ((array == nil || array.count == 0) ? YES:NO)
//xib快捷
#define UINib(name)[UINib nibWithNibName:name bundle:nil]

//状态栏隐藏显示 快捷方法
#define UITabBarHidden(YES) self.tabBarController.tabBar.hidden = YES



//当前网络状态
#define isNetConnected [AFNetMonitor sharedClient].isNetworkConnected

#define AppWindow [[UIApplication sharedApplication].delegate window]

#endif /* Macro_h */
