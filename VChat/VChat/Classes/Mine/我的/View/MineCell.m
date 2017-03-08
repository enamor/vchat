//
//  MineCell.m
//  VChat
//
//  Created by zhouen on 16/5/26.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MineCell.h"
@interface MineCell ()
@property (strong,nonatomic) UIImageView *headView;
@property (strong,nonatomic) UILabel *nickLabel;
@property (strong,nonatomic) UILabel *detailLabel;

@end
@implementation MineCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubview];
    }
    return self;
}

-(void)setupSubview{
    self.headView = [[UIImageView alloc] init];
    [self.contentView addSubview:_headView];
    self.nickLabel = [[UILabel alloc] init];
    _nickLabel.text = @"哈哈哈哈哈哈";
    [self.contentView addSubview:_nickLabel];
    self.detailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_detailLabel];
    
    _headView.backgroundColor = [UIColor redColor];
    _nickLabel.backgroundColor = [UIColor blueColor];
    _detailLabel.backgroundColor = [UIColor blueColor];

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat labelMargin = 5;
    CGFloat hx = 10;
    CGFloat hy = 10;
    CGFloat hw = self.height - 2*hy;
    CGFloat hh = hw;
    self.headView.frame = CGRectMake(hx, hy, hw, hh);
    
    CGFloat nh = 20;
    CGFloat ny = self.height/2.0 - nh - labelMargin;
    CGFloat nw = 150;
    CGFloat nx = self.headView.right + 10;
    self.nickLabel.frame = CGRectMake(nx, ny, nw, nh);
    
    CGFloat dh = nh;
    CGFloat dy = self.height/2.0 + labelMargin;
    CGFloat dw = kLuckScreenWidth/2.0;
    CGFloat dx = nx;
    self.detailLabel.frame = CGRectMake(dx, dy, dw, dh);
}


@end
