//
//  RegisterViewController.m
//  VChat
//
//  Created by zhouen on 16/5/29.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "RegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "UserHelper.h"
#import "UserModel.h"
#import "MD5Util.h"
@interface RegisterViewController ()<UITextFieldDelegate>
{
    NSTimer *_timer;
    int _totalTime;
}
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UITextField *areaCode;
@property (strong,nonatomic) UILabel *countryLabel;
@property (strong,nonatomic) UITextField *userField;
@property (strong,nonatomic) UITextField *authCode;
@property (strong,nonatomic) UIButton *gainCode;
@property (strong,nonatomic) UITextField *passwordField;
@property (strong,nonatomic) UIButton *registerButton;
@end

@implementation RegisterViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [self setupNavTheme];
    [self setupSubview];
}
-(void)setupNavTheme{
    // 取出appearance对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    //背景色
    navBar.barTintColor = kLuckBackgroundColor;
    //返回箭头的颜色
    navBar.tintColor = kLuckButtonThemeColor;
    //设置成yes的时候 半透明 iOS7
    navBar.translucent = YES;
    //去掉下方分界线
    [navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(didClickedCancelBtn:)];
    
    self.view.backgroundColor = kLuckBackgroundColor;
    
}

-(void)setupSubview{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(0, kLuckScreenHeight - 64 +50);
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    //描述
    UILabel *descripLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, self.view.width - 20, 35)];
    descripLabel.text = @"幸福就在指尖";
    [_scrollView addSubview:descripLabel];
    descripLabel.textAlignment = NSTextAlignmentCenter;
    descripLabel.font = [UIFont systemFontOfSize:20];
    
    //国家区号
    CGFloat cx = 15;
    CGFloat cy = descripLabel.bottom + 40;
    CGFloat cw = 90;
    CGFloat ch = 40;
    self.areaCode = [[UITextField alloc] initWithFrame:CGRectMake(cx, cy, cw, 38)];
    _areaCode.text = @"86";
    //加号
    UILabel *areaLeftView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 18, ch)];
    areaLeftView.text = @"＋";
    _areaCode.leftView = areaLeftView;
    _areaCode.leftViewMode = UITextFieldViewModeAlways;
    [_scrollView addSubview:_areaCode];
    //小短线
    UILabel *verticalLine = [[UILabel alloc] initWithFrame:CGRectMake(_areaCode.right, _areaCode.top +4, 1, 30)];
    verticalLine.alpha = 0.2;
    verticalLine.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:verticalLine];
    //国家
    self.countryLabel = [[UILabel alloc] initWithFrame:CGRectMake(_areaCode.right +15, cy, self.view.width - _areaCode.right, ch -5)];
    _countryLabel.text = @"中国";
    [_scrollView addSubview:_countryLabel];
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(cx, _countryLabel.bottom, self.view.width - cx, 1)];
    sepLine.backgroundColor = [UIColor lightGrayColor];
    sepLine.alpha = 0.2;
    [self.scrollView addSubview:sepLine];
    
    
    //用户名
    CGFloat ux = 15;
    CGFloat uy = sepLine.bottom + 20;
    CGFloat uw = self.view.width - ux - 10;
    CGFloat uh = 30;
    self.userField = [[UITextField alloc] initWithFrame:CGRectMake(ux, uy, uw, uh)];
    _userField.placeholder = @"请输入手机号";
    _userField.delegate = self;
    _userField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _userField.returnKeyType = UIReturnKeyDefault;
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_user"]];
    UIView *placeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, _userField.height)];
    image.center = placeView.center;
    [placeView addSubview:image];
    _userField.leftView = placeView;
    _userField.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_userField];
    //底部分割线
    CGFloat liw = self.view.width - ux;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(ux, _userField.bottom, liw, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.alpha = 0.2;
    [self.scrollView addSubview:lineView];
    
    //验证码
    CGFloat ax = ux;
    CGFloat ay = lineView.bottom +10;
    CGFloat aw = uw - 80 - 5;
    CGFloat ah = uh;
    self.authCode = [[UITextField alloc] initWithFrame:CGRectMake(ax, ay, aw, ah)];
    _authCode.placeholder = @"请输入验证码";
    UIImageView *auth_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register_code"]];
    UIView *auth_leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeView.width, ah)];
    auth_image.center = auth_leftView.center;
    [auth_leftView addSubview:auth_image];
    _authCode.leftView = auth_leftView;
    _authCode.delegate = self;
    _authCode.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_authCode];
    
    //获取验证码按钮
    self.gainCode = [[UIButton alloc] initWithFrame:CGRectMake(_authCode.right, _authCode.bottom - 35, 80, 35)];
    [_gainCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_gainCode setTitleColor:kLuckButtonShallowColor forState:UIControlStateNormal];
    _gainCode.layer.borderWidth = 1.0;
    _gainCode.layer.borderColor = [kLuckButtonShallowColor CGColor];
    _gainCode.layer.cornerRadius = 4.0;
    _gainCode.layer.masksToBounds = YES;
    _gainCode.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.scrollView addSubview:_gainCode];
    [_gainCode addTarget:self action:@selector(didClickedGainCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    //底部分割线
    UIView *auth_lineView = [[UIView alloc] initWithFrame:CGRectMake(ux, _authCode.bottom, liw, 1)];
    auth_lineView.backgroundColor = [UIColor lightGrayColor];
    auth_lineView.alpha = 0.2;
    [self.scrollView addSubview:auth_lineView];
    
    //密码
    CGFloat px = ux;
    CGFloat py = auth_lineView.bottom +10;
    CGFloat pw = uw;
    CGFloat ph = uh;
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(px, py, pw, ph)];
    _passwordField.placeholder = @"请设置密码";
    _passwordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _passwordField.returnKeyType = UIReturnKeyGo;
    _passwordField.secureTextEntry = YES;
    UIImageView *pimage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_password"]];
    UIView *pLeftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeView.width, ph)];
    pimage.center = pLeftView.center;
    [pLeftView addSubview:pimage];
    _passwordField.leftView = pLeftView;
    _passwordField.delegate = self;
    _passwordField.leftViewMode = UITextFieldViewModeAlways;
    [self.scrollView addSubview:_passwordField];
    //底部分割线
    UIView *pLineView = [[UIView alloc] initWithFrame:CGRectMake(ux, _passwordField.bottom, liw, 1)];
    pLineView.backgroundColor = [UIColor lightGrayColor];
    pLineView.alpha = 0.2;
    [self.scrollView addSubview:pLineView];
    
    //注册
    CGFloat lx = 15;
    CGFloat lw = self.view.width - 2*lx;
    CGFloat ly = _passwordField.bottom + 30;
    CGFloat lh = 44;
    self.registerButton = [[UIButton alloc] initWithFrame:CGRectMake(lx, ly, lw, lh)];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton addTarget:self action:@selector(didClickedRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    _registerButton.layer.cornerRadius = 4.0;
    _registerButton.layer.masksToBounds = YES;
    [self.scrollView addSubview:_registerButton];
    _registerButton.backgroundColor = kLuckButtonShallowColor;
//    _registerButton.enabled = NO;
    

}

#pragma mark 点击注册
-(void)didClickedRegisterBtn:(id)sender{
    [SMSSDK commitVerificationCode:self.areaCode.text phoneNumber:self.userField.text zone:@"86" result:^(NSError *error) {
        if (!error) {
            NSLog(@"验证成功");
        }
        else
        {
            NSLog(@"错误信息:%@",error);
        }
    }];
    
    
    UserModel *user  = [[UserModel alloc] init];
    user.account = self.userField.text;
    user.password = [MD5Util md5:self.passwordField.text];
    user.accountType = AccountTypeTel;
    [[UserHelper shareHelper] toRegisterUser:user success:^(id response) {
        NSLog(@"%@",response);
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
    
    
}
#pragma mark 点击取消
-(void)didClickedCancelBtn:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 点击获取验证码
-(void) didClickedGainCodeBtn:(id)sender{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.userField.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
        } else {
            NSLog(@"错误信息：%@",error);
        }
    }];
                                     
                                     
    _totalTime = 50;
    [self startCountDownAnimation];
    _gainCode.enabled = NO;
    [_gainCode setTitle:[NSString stringWithFormat:@"%d",_totalTime] forState:UIControlStateNormal];
    _gainCode.layer.borderColor = [[UIColor colorWithWhite:0.8 alpha:0.5] CGColor];
    [_gainCode setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(beginCountDown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
#pragma mark 开始倒计时
-(void)beginCountDown{
    _totalTime --;
    [self startCountDownAnimation];
    NSString *title = [NSString stringWithFormat:@"%d",_totalTime];
    if (_totalTime < 0) {
        [_timer invalidate];
        _timer = nil;
        _gainCode.enabled = YES;
        title = @"获取验证码";
        _gainCode.layer.borderColor = [kLuckButtonShallowColor CGColor];
        [_gainCode setTitleColor:kLuckButtonShallowColor forState:UIControlStateNormal];
    }
    [_gainCode setTitle:[NSString stringWithFormat:@"%@",title] forState:UIControlStateNormal];
}
-(void)startCountDownAnimation{
    CGAffineTransform t = _gainCode.titleLabel.transform;
    [UIView animateWithDuration:1 animations:^{
        _gainCode.titleLabel.transform = CGAffineTransformScale(t,0.4,0.4);
    } completion:^(BOOL finished) {
        _gainCode.titleLabel.transform  = CGAffineTransformIdentity;
    }];
}
-(void)dealloc{
    [_timer invalidate];
    _timer = nil;
}
@end
