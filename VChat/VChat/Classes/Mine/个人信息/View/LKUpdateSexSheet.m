//
//  LKUpdateSexSheet.m
//  VChat
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKUpdateSexSheet.h"
#import "UIImage+Extension.h"
@interface LKUpdateSexSheet ()
@property (weak,nonatomic) UIView *sheetView;
@property (strong,nonatomic) UIButton *manBtn;
@property (weak,nonatomic) UIButton *womBtn;
@property (weak,nonatomic) UIImageView *manRightImage;
@property (weak,nonatomic) UIImageView *womRightImage;
@end
@implementation LKUpdateSexSheet
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self addTapGestureWithTarget:self  action:@selector(didTapCover:)];
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview{
    UIView *sheet = [[NSBundle mainBundle]loadNibNamed:@"LKUpdateSexSheet" owner:nil options:nil].lastObject;
    [sheet addTapGestureWithTarget:self  action:@selector(didTapCover:)];
    sheet.userInteractionEnabled = YES;
    sheet.tag = 1111;
    CGFloat sh = 156;
    CGFloat sx = 20;
    CGFloat sw = (self.width - 2*sx);
    CGFloat sy = (self.height - sh)/2.0;
    sheet.frame = CGRectMake(sx, sy, sw, sh);
    
    [self addSubview:sheet];
    self.sheetView = sheet;
    sheet.layer.cornerRadius = 4.0;
    sheet.layer.masksToBounds = YES;
    
    self.manBtn = [sheet viewWithTag:101];
    self.womBtn = [sheet viewWithTag:102];
    self.manRightImage = [sheet viewWithTag:201];
    self.womRightImage = [sheet viewWithTag:202];
    [_manBtn addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
    
    [_manBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    
    [_womBtn addTarget:self action:@selector(didSelectItem:) forControlEvents:UIControlEventTouchUpInside];
    [_womBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
    
}

-(void)didSelectItem:(UIButton *)btn{
    int sex = btn.tag == 101?0:1;
    if (_sexBlock) {
        _sexBlock(sex);
    }
    [self removeFromSuperview];
}

-(void)setSex:(NSString *)sex{
    _sex = sex;
    if ([_sex isEqualToString:@"男"]) {
        _manRightImage.backgroundColor = [UIColor redColor];
    }else{
        _womRightImage.backgroundColor = [UIColor redColor];
    }
}

-(void)didTapCover:(UITapGestureRecognizer*)recognizer{
    if (recognizer.view.tag == 1111) {
        return;
    }
    [self removeFromSuperview];
}
@end
