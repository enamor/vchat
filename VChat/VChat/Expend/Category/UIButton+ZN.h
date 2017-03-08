//
//  UIButton+ZN.h
//  fate
//
//  Created by 周恩 on 15/10/26.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZN)
/*
 设置普通状态下的文字 和选中状态下的文字
 */
- (void)setTitle:(NSString *)normalTitle selectedTitle:(NSString *)selectedTitle;

/*
 设置普通状态下的文字 和高亮状态下的文字
 */
- (void)setTitle:(NSString *)normalTitle highlightedTitle:(NSString *)highlightedTitle;

/*
 设置普通状态下的图片 和选中状态下的图片
 */
-(void)setImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage;

/*
 设置普通状态下的图片 和高亮状态下的图片
 */
-(void)setImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage;

/*
 设置普通状态下title的颜色 和选中状态下的字体颜色
 */
-(void)setTitleColor:(UIColor *)normalTitleColor selectedTitleColor:(UIColor *)selectedTitleColor;
@end
