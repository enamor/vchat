//
//  SettingCell.m
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "SettingCell.h"
#import "ItemModel.h"
#import "Masonry.h"
#import <ReactiveCocoa.h>
@interface SettingCell ()
@property (strong,nonatomic) UIImageView *detailImage;
@property (strong,nonatomic) UILabel *detailTextLabel;

@property (strong,nonatomic) UISwitch *switchView;
@end

@implementation SettingCell
@synthesize detailTextLabel = _detailTextLabel;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.detailImage = [[UIImageView alloc] init];
        _detailImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_detailImage];
        
        self.detailTextLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.detailTextLabel];
        
        self.switchView = [UISwitch new];
        
         [_switchView addTarget:self action:@selector(swithChanged:) forControlEvents:UIControlEventValueChanged];
        
        
        
    }
    return self;
}

-(void)setItem:(ItemModel *)item{
    _item = item;
    self.imageView.image = item.image?:nil;
    self.textLabel.text = item.text?:nil;
    
    [self setupAccessoryType];
    
    if (item.detailText) {
        [self setupDetailText];
    }
    
    if (item.detailImage) {
        [self setupDetailImage];
    }
    
    //35 16  ,38  20
    
}

-(void)setupAccessoryType{
    if (self.item.accessoryType == ItemAccessoryTypeSwitch) {
        self.accessoryView = _switchView;
    }else if (self.item.accessoryType == ItemAccessoryTypeCustomView){
        self.accessoryView = _item.customView;
    }else{
        self.accessoryView = nil;
        self.accessoryType = (UITableViewCellAccessoryType)self.item.accessoryType;
    }
}

-(void)setupDetailText{
    CGFloat width = self.accessoryView.frame.size.width + 14 + 13;
    self.detailImage.image = nil;
    self.detailTextLabel.text = _item.detailText;
    @weakify(self);
    if (self.item.accessoryType == ItemAccessoryTypeNone) {
        width = 16;
        [_detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }else if(self.item.accessoryType == ItemAccessoryTypeDisclosureIndicator){
        width = 35;
        [_detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }else{
        [_detailTextLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
}

-(void)setupDetailImage{
    CGFloat width = self.accessoryView.frame.size.width + 14 + 13;
    self.detailTextLabel.text = nil;
    self.detailImage.image = _item.detailImage;
    @weakify(self);
    if (self.item.accessoryType == ItemAccessoryTypeNone) {
        width = 16;
        [_detailImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }else if(self.item.accessoryType == ItemAccessoryTypeDisclosureIndicator){
        width = 35;
        [_detailImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }else{
        [_detailImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.mas_right).with.offset(-width);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
        }];
    }
}

-(void)swithChanged:(UISwitch *)sender{
    if (_item.switchValueChanged) {
        _item.switchValueChanged(sender.isOn);
    }
}

@end
