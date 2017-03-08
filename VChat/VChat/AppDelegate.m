//
//  AppDelegate.m
//  VChat
//
//  Created by zhouen on 16/5/6.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "TabBarViewController.h"
#import "VideoChatHelper.h"
#import "HomeViewController.h"
#import "LoginViewController.h"
typedef enum{
    Background = 0,
    Foreground
}EnterType;

@interface AppDelegate ()
@property (strong,nonatomic) VideoChatHelper *videoChatHelper;
@property (strong, nonatomic) UIViewController *mainController;
@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [SMSSDK registerApp:kMobSMSAppKey withSecret:kMobSMSAppSecret];
    
    
    // easemob-demo#chatdemoui
    EMOptions *options = [EMOptions optionsWithAppkey:@"37#vchat"];
    options.apnsCertName = @"nil";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    //    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    
    
    [VideoChatHelper shareHelper];
    
    [self setupWindow];
//    [LKAppDelegate shareInstance];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self foregroundOrBackgroundEMOperation:Background withApplicaton:application];
    
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self foregroundOrBackgroundEMOperation:Foreground withApplicaton:application];

    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma 初始化 window
-(void)setupWindow{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window makeKeyAndVisible];
    //背景色
    _window.backgroundColor = kLuckBackgroundColor;
    
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    TabBarViewController *rootVc = [[TabBarViewController alloc] init];
     BaseNavigationController *baseNav = [[BaseNavigationController alloc]initWithRootViewController:rootVc];

    [VideoChatHelper shareHelper].mainVC = rootVc;
    
    _window.rootViewController = baseNav;
}

#pragma mark 注册环信 appkey 和推送证书
-(void)registerEMAppKey{
    //AppKey:注册的appKey，详细见下面注释。
    //apnsCertName:推送证书名(不需要加后缀)，详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"37#vchat"];
    options.apnsCertName = @"nil";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
}
#pragma mark 进入前后台 环信进行的操作
-(void)foregroundOrBackgroundEMOperation:(EnterType)enterType withApplicaton:(UIApplication *)application{
    if (enterType == Background) {//进入前台
        [[EMClient sharedClient] applicationDidEnterBackground:application];
    }else if (enterType == Foreground){
        [[EMClient sharedClient] applicationWillEnterForeground:application];

    }
}

@end
