//
//  UIImage+BlurEffect.h
//  VChat
//
//  Created by zhouen on 16/7/6.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BlurEffect)

/**
 *  毛玻璃效果
 *
 *  @param image 图片
 *  @param blur  透明度
 *
 *  @return image
 */
+(UIImage *)blurImage:(UIImage *)image withAlpha:(CGFloat)alpha;
@end
