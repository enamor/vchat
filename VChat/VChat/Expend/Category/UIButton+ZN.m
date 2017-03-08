//
//  UIButton+ZN.m
//  fate
//
//  Created by 周恩 on 15/10/26.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import "UIButton+ZN.h"

@implementation UIButton (ZN)

-(void)setTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle{
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

-(void)setImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage{
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:selectedImage forState:UIControlStateSelected];
}

-(void)setTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor{
    [self setTitleColor:normalTitleColor forState:UIControlStateNormal];
    [self setTitleColor:selectedTitleColor forState:UIControlStateSelected];
}

- (void)setTitle:(NSString *)normalTitle highlightedTitle:(NSString *)highlightedTitle{
    if (highlightedTitle == nil) {
        highlightedTitle = normalTitle;
    }
    [self setTitle:normalTitle forState:UIControlStateNormal];
    [self setTitle:highlightedTitle forState:UIControlStateHighlighted];
}

-(void)setImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage{
    [self setImage:normalImage forState:UIControlStateNormal];
    [self setImage:highlightedImage forState:UIControlStateHighlighted];
}


//取消按钮高亮状态
//- (void)setHighlighted:(BOOL)highlighted{}
@end
