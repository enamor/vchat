//
//  HomeNavMenuView.h
//  VChat
//
//  Created by zhouen on 16/5/23.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeNavMenuView : UIView
-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles;

/**
 *  根据滚动比例完成标示线的滚动
 *
 *  @param scale 滚动比例
 */
-(void)scrollByScale:(CGFloat)scale;

-(void)changeSelectedMenu:(NSInteger)index;
@end
