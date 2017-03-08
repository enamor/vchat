//
//  TabBarButton.m
//  fate
//
//  Created by 周恩 on 15/10/25.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import "TabBarButton.h"

//图片所占比例
#define kTabBarBtnImageRatio 0.7
@implementation TabBarButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
        self.titleLabel.font = kLuckTabBarItemFont;
        
#warning 颜色待定
        // 文字颜色
        [self setTitleColor:[UIColor grayColor] selectedTitleColor:[UIColor redColor]];
        

    }
    return self;
}
// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted {}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat ratio = kTabBarBtnImageRatio;
    if (_tabBarItem.title == nil) {
        ratio = 1.0;
    }
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * ratio;
    return CGRectMake(0, 2, imageW, imageH);
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat ratio = kTabBarBtnImageRatio;
    if (_tabBarItem.title == nil) {
        ratio = 1.0;
    }
    CGFloat titleY = contentRect.size.height * ratio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

-(void)setTabBarItem:(UITabBarItem *)tabBarItem{
    if (_tabBarItem != tabBarItem) {
        _tabBarItem = tabBarItem;
        // 设置文字
        [self setTitle:_tabBarItem.title selectedTitle:_tabBarItem.title];
        //设置图片
        [self setImage:_tabBarItem.image selectedImage:_tabBarItem.selectedImage];
    }
}


@end
