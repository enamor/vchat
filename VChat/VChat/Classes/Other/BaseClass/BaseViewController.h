//
//  BaseViewController.h
//  fate
//
//  Created by 周恩 on 15/10/30.
//  Copyright © 2015年 zhouen. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController
@property (copy,nonatomic) NSString *title;
@property (strong,nonatomic) UIView *titleView;
@property (strong,nonatomic) UIView *rightView;

-(void)pushViewController:(UIViewController *)viewController;
@end
