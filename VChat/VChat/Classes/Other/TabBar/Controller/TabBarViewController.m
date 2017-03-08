//
//  TabBarViewController.m
//  fate
//
//  Created by 周恩 on 15/10/25.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "LuckViewController.h"
#import "LKEnamorViewController.h"
#import "MineViewController.h"
#import "UIImage+Extension.h"
@interface TabBarViewController ()
//自定义tabbar
@property(nonatomic,weak) TabBarView *customTabBarView;

/*
 tabbar的子视图控制器
 */
@property(nonatomic,weak) HomeViewController *homeVC;
@property(nonatomic,weak) MineViewController *mineVC;

@property (strong,nonatomic) LuckViewController *luckVC;

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:kLuckThemeColor]];
    //边界线透明化
    self.tabBar.shadowImage = [[UIImage alloc]init];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    // 初始化tabbar
    [self setupTabbar];
    //设置子视图
    [self setupChildVc];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    TabBarView *customTabBar = [[TabBarView alloc] init];
    customTabBar.delegate = self;
    customTabBar.isShowCustomBtn = YES;
    customTabBar.frame = self.tabBar.bounds;
    [self.tabBar addSubview:customTabBar];
    self.customTabBarView = customTabBar;
}
#pragma mark 设置每个tabbar对应的视图控制器
- (void)setupChildVc{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self setupChildViewController:homeVC title:nil imageName:@"tab_leaf" selectedImageName:@"tab_leaf_HL"];
    self.homeVC = homeVC;
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self setupChildViewController:mineVC title:nil imageName:@"tab_mine" selectedImageName:@"tab_mine_HL"];
    self.mineVC = mineVC;
    
}
- (void)setupChildViewController:(BaseViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 2.包装一个导航控制器
//    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:childVc];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBarView addTabBarButtonWithItem:childVc.tabBarItem];
}

#pragma mark 切换tabBar
- (void)tabBarView:(TabBarView *)tabBarView didSelectedItem:(NSInteger)selectedIndex from:(NSInteger)lastIndex{
    self.selectedIndex  = selectedIndex;
}
//点击了中间按钮
- (void) tabbarView:(TabBarView *)tabbarView didClickedCenterButton:(UIButton *)button{
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:[LKEnamorViewController new]];
    [self presentViewController:navVC animated:YES completion:nil];
}

-(LuckViewController *)luckVC{
    if (nil == _luckVC) {
        _luckVC = [[LuckViewController alloc] init];
    }
    return _luckVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
