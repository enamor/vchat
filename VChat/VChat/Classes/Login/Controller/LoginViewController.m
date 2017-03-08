//
//  LoginViewController.m
//  VChat
//
//  Created by zhouen on 16/5/27.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "BaseNavigationController.h"
#import "TabBarViewController.h"
#import "CryptUtil.h"
#import "UserModel.h"
#import "UserHelper.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (strong,nonatomic) UIScrollView   *scrollView;
@property (strong,nonatomic) UIImageView    *headView;
@property (strong,nonatomic) UITextField    *userField;
@property (strong,nonatomic) UITextField    *passwordField;
@property (strong,nonatomic) UIButton       *loginButton;

@end

@implementation LoginViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = kLuckBackgroundColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self setupSubview];
}

-(void)setupSubview{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(0, kLuckScreenHeight + 50);
    _scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    //头像
    CGFloat hw = 80;
    CGFloat hh = hw;
    CGFloat hx = (self.view.width - hw)/2.0;
    CGFloat hy = 80;
    self.headView = [[UIImageView alloc] initWithFrame:CGRectMake(hx, hy, hw, hh)];
    _headView.layer.cornerRadius = 4.0;
    _headView.layer.masksToBounds = YES;
    [self.scrollView addSubview:_headView];
    _headView.backgroundColor = [UIColor grayColor];
    
    //用户名
    CGFloat ux = 15;
    CGFloat uy = _headView.bottom +30;
    CGFloat uw = self.view.width - ux - 10;
    CGFloat uh = 30;
    self.userField = [[UITextField alloc] initWithFrame:CGRectMake(ux, uy, uw, uh)];
    _userField.placeholder = @"手机号";
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
    
    //密码
    CGFloat px = ux;
    CGFloat py = lineView.bottom +10;
    CGFloat pw = uw;
    CGFloat ph = uh;
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(px, py, pw, ph)];
    _passwordField.placeholder = @"密码";
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
    
    //登录
    CGFloat lx = 15;
    CGFloat lw = self.view.width - 2*lx;
    CGFloat ly = _passwordField.bottom + 30;
    CGFloat lh = 44;
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(lx, ly, lw, lh)];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton addTarget:self action:@selector(didClickedLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    _loginButton.layer.cornerRadius = 4.0;
    _loginButton.layer.masksToBounds = YES;
    [self.scrollView addSubview:_loginButton];
    _loginButton.backgroundColor = kLuckButtonShallowColor;
    _loginButton.enabled = NO;
    
    //注册
    CGFloat rw = 150;
    CGFloat rh = 44;
    CGFloat rx = (self.view.width - rw)/2.0;
    CGFloat ry = self.view.height - rh - 15;
    UIButton *registerButton = [[UIButton alloc] initWithFrame:CGRectMake(rx, ry, rw, rh)];
    [self.view addSubview:registerButton];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton addTarget:self action:@selector(didClickedRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitleColor:kLuckButtonDefaultColor forState:UIControlStateNormal];
}

#pragma mark 点击登录
-(void)didClickedLoginBtn:(UIButton *)btn{
    
    UserModel *user = [[UserModel alloc] init];
    user.account = self.userField.text;
    NSString *password = self.passwordField.text;
    user.password = [MD5Util md5:password];
    
    [[UserHelper shareHelper] toLoginWithUser:user success:^(id response) {
        TabBarViewController *rootVc = [[TabBarViewController alloc] init];
        AppWindow.rootViewController = rootVc;

    } failure:^(NSError *error) {
        
    }];
     
}

#pragma mark 点击注册
-(void)didClickedRegisterBtn:(UIButton *)btn{
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:[[RegisterViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark 键盘点击右下角
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self.userField isFirstResponder]) {
        [self.passwordField becomeFirstResponder];
    }else if([_passwordField isFirstResponder]){
        if (_userField.text.length > 0) {
            //执行登录操作
            [_passwordField resignFirstResponder];
            
        }else{
            [_userField becomeFirstResponder];
        }
    }
    
    return NO;
}
- (void)textFieldDidChange:(NSNotification *)noti{
    if (_userField.text.length && _passwordField.text.length) {
        _loginButton.backgroundColor = kLuckButtonThemeColor;
        _loginButton.enabled = YES;
    }else{
        _loginButton.backgroundColor = kLuckButtonShallowColor;
        _loginButton.enabled = NO;
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
