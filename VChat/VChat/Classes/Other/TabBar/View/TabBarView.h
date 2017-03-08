//
//  TabBarView.h
//  fate
//
//  Created by 周恩 on 15/10/25.
//  Copyright © 2015年 zhouen. All rights reserved.
//


@class TabBarView;
@protocol TabBarViewDelegate <NSObject>
/*
 切换tabBarItem的方法
 */
- (void) tabBarView:(TabBarView *)tabBarView didSelectedItem:(NSInteger)selectedIndex from:(NSInteger)lastIndex;

//点击了中间按钮
- (void) tabbarView:(TabBarView *)tabbarView didClickedCenterButton:(UIButton *)button;

@end
@interface TabBarView : UIView
@property(nonatomic,weak) id<TabBarViewDelegate> delegate;
@property (assign,nonatomic) BOOL isShowCustomBtn;

- (void)addTabBarButtonWithItem:(UITabBarItem *)item;
@end
