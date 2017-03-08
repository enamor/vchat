//
//  LKRandomViewController.m
//  VChat
//
//  Created by zhouen on 16/9/19.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKRandomViewController.h"
#import "LKRandomChatView.h"

@interface LKRandomViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;

@property (strong,nonatomic) UIView *callView;
@property (strong,nonatomic) LKRandomChatView *randomView;

@property (strong,nonatomic) UIView *currentView;
@property (strong,nonatomic) UIView *rightView;

@property (assign,nonatomic) BOOL  isCallCurrent;


@end

@implementation LKRandomViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self _initScrollView];
    [self _initRandomView];
    
}

- (void)_initScrollView {
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:_scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor orangeColor];
    _scrollView.bounces = NO;
    _scrollView.contentSize = CGSizeMake(self.view.width *2, 0);
}

- (void)_initRandomView{
    [self.scrollView addSubview:self.randomView];
    [self.scrollView addSubview:self.callView];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x == self.view.width) {
        _isCallCurrent = !_isCallCurrent;
        if (_isCallCurrent) {
            _callView.left = 0;
            _randomView.left = self.view.width;
            [_randomView stopRrandomAnimation];
        }else{
            _randomView.left = 0;
            [_randomView startRrandomAnimation];
            _callView.left = self.view.width;
        }
        [self.scrollView setContentOffset:CGPointZero];
    }else{
        [self prepareVideoChat];
    }
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [self chancelVideoChat];
}

-(void)reset{
    _isCallCurrent = NO;
    _randomView.left = 0;
    _callView.left = self.view.width;
}

-(void)prepareVideoChat{
    [self.randomView startRrandomAnimation];
}
-(void)chancelVideoChat{
    [self.randomView stopRrandomAnimation];
}
- (UIView *)callView{
    if (nil == _callView) {
        _callView = [[UIView alloc] initWithFrame:CGRectMake(self.view.width, 0, self.view.width, self.view.height)];
        _callView.backgroundColor = [UIColor redColor];
    }
    return _callView;
}

- (UIView *)randomView{
    if (nil == _randomView) {
        
        NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"LKRandomChatView" owner:nil options:nil];
        _randomView = views[0];
        
        _randomView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
        _randomView.backgroundColor = [UIColor grayColor];
    }
    return _randomView;
}

-(void)didClickedBtn{
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor greenColor];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
