//
//  LKEnamorViewController.m
//  VChat
//
//  Created by zhouen on 16/9/19.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKEnamorViewController.h"
#import "LKPrefixViewController.h"
#import "LKRandomViewController.h"

@interface LKEnamorViewController ()<UIScrollViewDelegate>
@property (weak,nonatomic) LKPrefixViewController *prefixViewVC;
@property (weak,nonatomic) LKRandomViewController *randomViewVC;
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation LKEnamorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initNavTheme];
    [self _initScrollView];
    [self _initPrefixView];
    
    self.view.backgroundColor = kLuckBackgroundColor;
}

- (void)_initNavTheme{
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)_initScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.left.bottom.right.equalTo(self.view);
    }];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)_initPrefixView{
    LKPrefixViewController *prefixVc = [[LKPrefixViewController alloc] init];
    [self addChildViewController:prefixVc];
    self.prefixViewVC = prefixVc;
    [self.scrollView addSubview:prefixVc.view];
    [prefixVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.scrollView);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
    }];
    
    LKRandomViewController *randomVc = [[LKRandomViewController alloc] init];
    [self addChildViewController:randomVc];
    self.randomViewVC = randomVc;
    [self.scrollView addSubview:randomVc.view];
    [randomVc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(prefixVc.view.mas_right);
        make.top.and.bottom.and.right.equalTo(self.scrollView);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
    }];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == self.view.width) {
        [self.prefixViewVC stopRunning];
        [self.randomViewVC prepareVideoChat];
    }else{
        [self.prefixViewVC startRunning];
        [self.randomViewVC reset];
    }
}


-(void)dealloc{
    NSLog(@"----------LKEnamorViewController ------dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
