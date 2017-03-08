//
//  TabBarView.m
//  fate
//
//  Created by 周恩 on 15/10/25.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import "TabBarView.h"
#import "TabBarButton.h"

@interface TabBarView ()
@property(nonatomic,strong) NSMutableArray *itemArray;
@property(nonatomic,weak) UIButton *selectedTabBar;
@property (weak,nonatomic) UIButton *centerButton;
@end
@implementation TabBarView

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    TabBarButton *button = [[TabBarButton alloc] init];
    [self addSubview:button];
    // 添加按钮到数组中
    [self.itemArray addObject:button];
    
    // 2.设置数据
    button.tabBarItem = item;
    
    // 3.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    if (_itemArray.count == 1) {
        [self buttonClick:button];
    }
}

#pragma mark 点击每个tabBarItem 的方法
- (void)buttonClick:(TabBarButton *)btn{
    
    if ([_delegate respondsToSelector:@selector(tabBarView:didSelectedItem:from:)]) {
        [_delegate tabBarView:self didSelectedItem:btn.tag from:_selectedTabBar.tag];
    }
    _selectedTabBar.selected = NO;
    btn.selected = YES;
    _selectedTabBar = btn;
}


//3个 或 5个
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_isShowCustomBtn) {
        //添加中间自定义按钮
        [self setupCenterCustomButton];
    }
    // 调整加号按钮的位置
    self.centerButton.center = self.center;
    
    
    CGFloat h = self.frame.size.height;
    CGFloat w = self.frame.size.width;
    // 按钮的frame数据
    CGFloat buttonH = h;
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index< self.itemArray.count; index++) {
        // 1.取出按钮
        TabBarButton *button = self.itemArray[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        // if _isShowCustomBtn = yes 显示中间btn
        CGFloat sepIndex = self.subviews.count == 5?1:(self.subviews.count == 3)?0:10;
        if (index > sepIndex  && _isShowCustomBtn) {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}

//中间自定义按钮
- (void)setupCenterCustomButton{
    if (nil == _centerButton) {
        // 添加一个加号按钮
        UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [centerButton setBackgroundImage:[UIImage imageNamed:@"tab_love@3x"] forState:UIControlStateNormal];
//        [centerButton setBackgroundImage:[UIImage imageNamed:@"tab_love@3x"] forState:UIControlStateHighlighted];
        [centerButton setImage:[UIImage imageNamed:@"tab_love"] forState:UIControlStateNormal];
        [centerButton setImage:[UIImage imageNamed:@"tab_love"] forState:UIControlStateHighlighted];
        
        centerButton.bounds = CGRectMake(0, 0, centerButton.currentImage.size.width, centerButton.currentImage.size.height);
        [centerButton addTarget:self action:@selector(centerButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:centerButton];
        self.centerButton = centerButton;
    }
}

-(void)centerButtonDidClicked:(UIButton *)btn{
    if (_delegate && [_delegate respondsToSelector:@selector(tabbarView:didClickedCenterButton:)]) {
        [_delegate tabbarView:self didClickedCenterButton:btn];
    }
}

-(NSMutableArray *)itemArray{
    if (nil == _itemArray) {
        self.itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

@end
