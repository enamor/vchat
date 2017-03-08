//
//  PersonalInfoViewController.m
//  VChat
//
//  Created by zhouen on 16/8/11.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "UIImage+Extension.h"
#import "LKActionSheet.h"
#import "UserHelper.h"
#import "LKUpdateNameViewController.h"
#import "LKUpdateSexSheet.h"
#import "LKProvinceViewController.h"
#import "LKSignatureViewController.h"

static NSString *headerReuseIdentifier = @"PersonHeaderView";
static NSString *reuseIdentifier = @"personCell";

@interface PersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource,LKActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *titles;
@property (strong,nonatomic) __block NSMutableDictionary *updatePara;

@end
@implementation PersonalInfoViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    _titles = @[@[@{@"title":@"头像",@"action":@"didSelectHeaderImage"}],
                @[@{@"title":@"昵称",@"action":@"didSelectNickName"}
                  ,@{@"title":@"聊聊号",@"action":@"didSelectMine"}
                  ,@{@"title":@"二维码名片",@"action":@"didSelectMine"}
                  ,@{@"title":@"我的地址",@"action":@"didSelectMine"}],
                @[@{@"title":@"性别",@"action":@"didSelectSex"}
                  ,@{@"title":@"地区",@"action":@"didSelectRegion"}
                  ,@{@"title":@"签名",@"action":@"didSelectSignature"}],
                ];
    [self _initTabelView];
    
    self.title = @"个人信息";
}

- (void) _initTabelView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor=[UIColor colorWithWhite:0.5 alpha:0.5];
    tableView.backgroundColor = [UIColor clearColor];
    [tableView setExclusiveTouch:YES];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
//    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
}

#pragma mark 上传头像
-(void)didSelectHeaderImage{
    LKActionSheet *sheet = [[LKActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitle:@"拍照",@"从手机相册选择", nil];
    [sheet setCancelButtonTitleColor:[UIColor blackColor] fontSize:0];
    [sheet setButtonTitleColor:[UIColor blackColor] fontSize:0];
    [sheet show];
}
-(void)actionSheet:(LKActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self openCamera];//打开相机
            break;
        case 1:
            [self openPhotoAlbum];//打开相册
            break;
            
        default:
            break;
    }
}
#pragma mark 打开相机
-(void)openCamera{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"警告" message:@"请使用真机进行" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
    
}

#pragma mark 打开相册
-(void)openPhotoAlbum{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
        
    }
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark - 当在相册选择一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        
        //先把图片转成NSData
        UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        //调整图片方向，防止上传后图片方向不对
        image = [UIImage fixOrientation:image];
        NSData *data = nil;
        NSString *fileName = nil;
        long long currentTime = [[NSDate date] timeIntervalSince1970]*1000;
        if (UIImagePNGRepresentation(image)) {
            //返回为png图像。
            fileName = [NSString stringWithFormat:@"%lld.png",currentTime];
        }else {
            //返回为JPEG图像。
            fileName = [NSString stringWithFormat:@"%lld.jpeg",currentTime];
        }
        data = [self imageData:image];
        
        [[UserHelper shareHelper] uploadHeaderImage:data fileName:fileName success:^(id response) {
            NSLog(@"成功");
        } failure:^(id error) {
            NSLog(@"失败");
        }];
    }
}

#pragma mark - 取消图片选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerReuseIdentifier];
    view.contentView.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }
    return 44;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titles = self.titles[indexPath.section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = titles[indexPath.row][@"title"];
    cell.textLabel.font  = kLuckNormalFont;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    if (indexPath.section == 0) {
        
    }else{
        UILabel *desLabel = [[UILabel alloc] init];
        desLabel.font = kLuckNoteFont;
        desLabel.textColor = [UIColor grayColor];
        desLabel.text = @"恍恍惚惚好";
        [desLabel sizeToFit];
        cell.accessoryView = desLabel;
    }
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = self.titles[indexPath.section];
    NSString *action = array[indexPath.row][@"action"];
    SEL selector = NSSelectorFromString(action);
    if (![self respondsToSelector:selector]) return;
    ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
}

-(void)didSelectNickName{
    LKUpdateNameViewController *updateName = [[LKUpdateNameViewController alloc] init];
    @weakify(self);
    updateName.saveBlock = ^(NSString *nickName){
        @strongify(self);
        [self.updatePara setObject:nickName forKey:@"nickName"];
    };
    [self pushViewController:updateName];
}

#pragma mark 性别
-(void)didSelectSex{
    LKUpdateSexSheet *sheet = [[LKUpdateSexSheet alloc] initWithFrame:self.view.bounds];
    sheet.sex = @"男";
    sheet.sexBlock = ^(int sex){
        [self.updatePara setObject:@(sex) forKey:@"sex"];
    };
    [self.view addSubview:sheet];
    sheet.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        sheet.alpha = 1.0;
    }completion:^(BOOL finished) {
        
    }];
}

#pragma mark 地区
-(void)didSelectRegion{
    LKProvinceViewController *provinceVC = [[LKProvinceViewController alloc] init];
    [self pushViewController:provinceVC];
}

#pragma mark 签名
-(void)didSelectSignature{
    LKSignatureViewController *singVC = [[LKSignatureViewController alloc] init];
    [self pushViewController:singVC];
}
-(NSMutableDictionary *)updatePara{
    if (nil == _updatePara) {
        _updatePara = [NSMutableDictionary dictionary];
    }
    return _updatePara;
}



@end
