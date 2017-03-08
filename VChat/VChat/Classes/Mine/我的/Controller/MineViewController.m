//
//  MineViewController.m
//  VChat
//
//  Created by zhouen on 16/5/9.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "MineViewController.h"
#import "MineCell.h"
#import "MineOtherCell.h"
#import "PersonalInfoViewController.h"
#import "SettingViewController.h"
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSArray *titles;
@end

static NSString *reuseIdentifier = @"MineOtherCell";
static NSString *headerReuseIdentifier = @"HeaderView";
static NSString *mineCellReuseIdentifier = @"MineCell";

@implementation MineViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我的";
    _titles = @[@[@{@"title":@"我的",@"action":@"didSelectMine"}],
                @[@{@"title":@"测试",@"action":@"didSelectMine"}
                  ,@{@"title":@"测试",@"action":@"didSelectMine"}],
                @[@{@"title":@"测试",@"action":@"didSelectMine"}
                  ,@{@"title":@"测试",@"action":@"didSelectMine"}],
                @[@{@"title":@"设置",@"action":@"didSelectSetting",@"image":@"mine_setting"}]
                 ];
    [self _initTabelView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
    self.title = @"我的";

    
}

- (void) _initTabelView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorColor = kLuckThemeColor;
    [tableView setExclusiveTouch:YES];
    tableView.backgroundColor = [UIColor clearColor];
    [tableView registerClass:[MineOtherCell class] forCellReuseIdentifier:reuseIdentifier];
    [tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:headerReuseIdentifier];
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
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titles = self.titles[indexPath.section];
    if (indexPath.section == 0) {
        MineCell *cell = [[MineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineCellReuseIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
        NSString *str = titles[indexPath.row][@"image"];
        cell.detailTextLabel.text = @"哈哈哈";
        UIImage *image = [UIImage imageNamed:str];
        if (image) {
            cell.imageView.image = image;
        }else{
            cell.imageView.image = [UIImage imageNamed:@"shareFavorites@2x"];
        }
        cell.textLabel.text = titles[indexPath.row][@"title"];
        
        NSLog(@"%@",NSStringFromCGRect(cell.textLabel.frame));
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        CGRect poi = cell.accessoryView.frame;
        NSLog(@"%@",NSStringFromCGRect(poi));
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSArray *array = self.titles[indexPath.section];
    NSString *action = array[indexPath.row][@"action"];
    SEL selector = NSSelectorFromString(action);
    ((void (*)(id, SEL))[self methodForSelector:selector])(self, selector);
    
//    SEL selector = NSSelectorFromString(@"someMethod");
//    IMP imp = [self methodForSelector:selector];
//    void (*func)(id, SEL) = (void *)imp;
//    func(self, selector);
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)didSelectMine{
    [self.navigationController pushViewController:[[PersonalInfoViewController alloc] init] animated:YES];
}

-(void)didSelectSetting{
    [self.navigationController pushViewController:[[SettingViewController alloc] init] animated:YES];
}
@end
