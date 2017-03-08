//
//  LKSignatureViewController.m
//  VChat
//
//  Created by zhouen on 16/9/1.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKSignatureViewController.h"
#import "LKSignViewModel.h"

@interface LKSignatureViewController ()
@property (weak,nonatomic) UITextView *textView;

@property (strong,nonatomic) LKSignViewModel *signViewModel;

@end

@implementation LKSignatureViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupSubview];
    [self setupObserver];
}

-(void)setupSubview{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:nil action:nil];

    UITextView *textView = [[UITextView alloc] init];
    textView.scrollEnabled = NO;
    textView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:textView];
    self.textView = textView;
    
    UIEdgeInsets padding = UIEdgeInsetsMake(20, 15, 0, 15);
    @weakify(self);
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.top.equalTo(self.view.mas_top).with.offset(padding.top);
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.right.equalTo(self.view.mas_right).with.offset(-padding.right);
        make.height.mas_equalTo(30);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = kLuckThemeColor;
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom);
        make.left.equalTo(textView.mas_left);
        make.right.equalTo(textView.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.text = @"30";
    countLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:countLabel];
    [countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).with.offset(4);
        make.right.equalTo(lineView.mas_right).with.offset(-10);
        
    }];

    
    [textView.rac_textSignal subscribeNext:^(NSString *x) {
        if (x.length > 30) {
            [textView deleteBackward];
        }
        countLabel.text = [NSString stringWithFormat:@"%u",30-textView.text.length];
        CGFloat width = CGRectGetWidth(textView.frame);
        CGFloat newHeight = [textView sizeThatFits:CGSizeMake(width,MAXFLOAT)].height;
        [textView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@(newHeight));
        }];
    }];
}

-(void)setupObserver{
    _signViewModel = [[LKSignViewModel alloc] init];
    RAC(_signViewModel,signStr) = _textView.rac_textSignal;
    self.navigationItem.rightBarButtonItem.rac_command = _signViewModel.saveCommand;
    [_signViewModel.saveCommand.executionSignals subscribeNext:^(id x) {
        
        
    }];
}


@end
