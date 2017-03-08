//
//  HomeNavMenuView.m
//  VChat
//
//  Created by zhouen on 16/5/23.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "HomeNavMenuView.h"

#define kGuideBtnWidth  54
#define kLrMargin 10
#define kTag 1990
#define kMargin 2

@interface HomeNavMenuView ()
@property (strong,nonatomic) NSArray *titles;
@property (weak,nonatomic) UIButton *selectBtn;
@property (weak,nonatomic) UIView *lineView;
@end
@implementation HomeNavMenuView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame andTitles:(NSArray *)titles{
    _titles = titles;
    return [self initWithFrame:frame];
    
}
-(void)setupSubviews{
    CGFloat width = kGuideBtnWidth;
    CGFloat lrMargin = kLrMargin;
    CGFloat margin =  (self.frame.size.width - 2*lrMargin - _titles.count*width)/(_titles.count -1);
    
    for (int index = 0; index < _titles.count; index ++) {
        CGFloat x  =  lrMargin + index*(width + margin);
        UIButton *btn  = [[UIButton alloc] initWithFrame:CGRectMake(x, 4, width, 40)];
        [btn setTitle:_titles[index] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        [btn addTarget:self action:@selector(didClickedGuideBtn:) forControlEvents:UIControlEventTouchDown];
        btn.tag = index + kTag;
        [self addSubview:btn];
        
        if (index == 0) {
            btn.selected = YES;
            _selectBtn = btn;
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(x,self.frame.size.height - 2,  width, 2)];
            [self addSubview:lineView];
            lineView.backgroundColor = kLuckWhiteColor;
            self.lineView = lineView;
        }
    }
}

-(void)scrollByScale:(CGFloat)scale{
    CGFloat width = kGuideBtnWidth;
    CGFloat lrMargin = kLrMargin;
    CGFloat margin =  (self.width - 2*kLrMargin - self.titles.count*width)/(self.titles.count -1.0);
    [UIView animateWithDuration:0.1 animations:^{
        CGRect rect = self.lineView.frame;
        rect.origin.x = (width +margin)*scale + lrMargin;
        self.lineView.frame = rect;
    }];
}

#pragma mark 点击引导菜单
-(void)didClickedGuideBtn:(UIButton *)btn{
    if (_selectBtn != btn) {
        btn.selected = YES;
        _selectBtn.selected = NO;
        _selectBtn = btn;
        
        [UIView animateWithDuration:0.1 animations:^{
            CGRect rect = self.lineView.frame;
            rect.origin.x = btn.left;
            self.lineView.frame = rect;
        }];
    }
}
-(void)changeSelectedMenu:(NSInteger)index{
    UIButton *btn = [self viewWithTag:index + kTag];
    if (_selectBtn.tag - kTag != index) {
        btn.selected = YES;
        _selectBtn.selected = NO;
        _selectBtn = btn;
    }
}
@end
