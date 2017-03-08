//
//  HomeViewController.m
//  VChat
//
//  Created by zhouen on 16/5/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeNavMenuView.h"
#import "AESUtil.h"
#import "AppDelegate.h"
#import "LKGlobalUser.h"
@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) HomeNavMenuView *menuView;
@property (weak,nonatomic) UICollectionView *collectionView;
@property (strong,nonatomic) UITextField *field;
@property (strong,nonatomic) NSArray *titles;
@end

static NSString *reuserIdentifier = @"baseCell";
@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *dict = @{
                           @"uid" : @11111111,
                           @"token" : @"lfefefedvmdkkdkdkdkd",
                           @"nickName" : @"fefefefe",
                           @"province" : @"山东省",
                           @"city" : @"东营市",
                           @"area" : @"河口区",
                           @"sex":@44
                           };
    LKGlobalUser *user = [LKGlobalUser shareInstance];
    [user updateGlobalUserByDict:dict];

    [self setupNavigationBar];
    [self setupSubviews];
    [self setupCollectionView];
    
    [user clearGlobalUser];
    
}

-(void)didTapView{
    [self.view endEditing:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.titleView = self.menuView;
}
-(void)setupNavigationBar{
    _titles = @[@"关注",@"历史"];
    
}
-(void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.itemSize = CGSizeMake(kLuckScreenWidth, kLuckScreenHeight);
    flowLayout.headerReferenceSize = CGSizeMake(0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kLuckScreenWidth, kLuckScreenHeight) collectionViewLayout:flowLayout];
    [self.view addSubview:collectionView];
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource  = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuserIdentifier];
    self.collectionView = collectionView;
    
}

-(void)setupSubviews{
    _titles = @[@"关注",@"历史"];
    self.view.backgroundColor = [UIColor grayColor];
    
    UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(20, 100, 200, 40)];
    [self.view addSubview:field];
    field.backgroundColor = [UIColor whiteColor];
    self.field = field;
    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"登陆" forState:UIControlStateNormal];
    button1.frame=CGRectMake(100, 200, 50, 30);
    [button1 setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(loginCLick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    field.text = @"test2";
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"设置" forState:UIControlStateNormal];
    button.frame=CGRectMake(100, 300, 50, 30);
    [button setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuserIdentifier forIndexPath:indexPath];
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        CGFloat scale = scrollView.contentOffset.x/kLuckScreenWidth;
        [self.menuView scrollByScale:scale];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger offset = collectionView.contentOffset.x / kLuckScreenWidth;
    [self.menuView changeSelectedMenu:offset];
}

/*----------------------------------------*/
-(void)loginCLick{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:self.field.text password:@"111111"];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (!error) {
                
                NSLog(@"登录成功");
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.field.text message: @"登陆成功" delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
                [alertView show];
            } else {
                NSLog(@"登录失败---------%@", error);
            }
        });
    });
    
}
-(HomeNavMenuView *)menuView{
    if (nil == _menuView) {
        _menuView = [[HomeNavMenuView alloc] initWithFrame:CGRectMake(0, 0, 130, 44) andTitles:_titles];
    }
    return _menuView;
}
-(void)buttonClick{
    NSString *call = self.field.text;
    if ([call isEqualToString:@"test1"]) {
        call = @"test2";
    }else if ([call isEqualToString:@"test2"]){
        call = @"test1";
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:call message: @"准备呼叫" delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
    [alertView show];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_CALL object:@{@"chatter":call, @"type":[NSNumber numberWithInt:1]}];
    
    NSLog(@"button click");
}

@end
