//
//  LKUpdateNameViewController.m
//  vchat
//
//  Created by zhouen on 16/8/17.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKUpdateNameViewController.h"
#import "UIView+Toast.h"
#import "LKUpdateNameViewModel.h"

@interface LKUpdateNameViewController ()
@property (strong,nonatomic) LKUpdateNameViewModel *updateViewModel;
@property (weak,nonatomic) UITextField *nickNameField;
@end
@implementation LKUpdateNameViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    _updateViewModel = [[LKUpdateNameViewModel alloc] init];
    [self setupNav];
    [self setupSubview];
}

-(void)setupSubview{
    
    self.view.backgroundColor = HEX_COLOR(0xf7f7f7);
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 54)];
    bgView.backgroundColor = HEX_COLOR(0xffffff);
    [self.view addSubview:bgView];
    
    UILabel *desLabel = [[UILabel alloc] init];
    desLabel.font = [UIFont systemFontOfSize:14];
    desLabel.textColor = HEX_COLOR(0x000000);
    desLabel.text = @"修改昵称";
    [desLabel sizeToFit];
    desLabel.frame = CGRectMake(12, 0, desLabel.width, bgView.height);
    [bgView addSubview:desLabel];
   
    CGFloat tx = desLabel.right + 20;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(tx, 0, self.view.width -tx -6, bgView.height)];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    NSMutableParagraphStyle *style = [textField.defaultTextAttributes[NSParagraphStyleAttributeName] mutableCopy];
    
    style.minimumLineHeight = textField.font.lineHeight - (textField.font.lineHeight - [UIFont systemFontOfSize:12.0].lineHeight) / 2.0;
    textField.attributedPlaceholder = [[NSAttributedString alloc]
                                        initWithString:@"输入新的昵称"
                                       attributes:@{NSForegroundColorAttributeName:HEX_COLOR(0x6f7082),NSFontAttributeName:[UIFont systemFontOfSize:12],NSParagraphStyleAttributeName : style}];
    textField.font = [UIFont systemFontOfSize:12];
    
 
    
    [bgView addSubview:textField];
    self.nickNameField = textField;
    _nickNameField.text = _nickName;
    
    RAC(_updateViewModel,nickName) = self.nickNameField.rac_textSignal;
    
    [[_updateViewModel.saveCommand executionSignals] subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            
            NSLog(@"%@",x);
            if (_saveBlock) {
                _saveBlock(x);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }];
//    [[_updateViewModel.saveCommand.executionSignals flattenMap:^(RACSignal *execution) {
//        // Sends RACUnit after the execution completes.
//        return [[execution ignoreValues] concat:[RACSignal return:RACUnit.defaultUnit]];
//    }] subscribeNext:^(id _) {
////        @strongify(self);
//        NSLog(@"sss");
//    }];

}

- (void)setupNav{
    self.title = @"修改资料";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem.rac_command = _updateViewModel.saveCommand;
}

-(void)didClickedSave:(id)sender{
    NSString *nickName = [_nickNameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (nickName.length == 0) {
        [self.view makeToast:@"请输入昵称"];
    }
    if (_saveBlock) {
        _saveBlock(nickName);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickedBackBtn:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
