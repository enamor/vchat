//
//  SettingViewController.m
//  ReactiveCocoaDemo
//
//  Created by zhouen on 16/9/2.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "SettingViewController.h"
#import "SectionModel.h"
#import "ItemModel.h"
#import "SettingCell.h"

@interface SettingViewController ()
@property (strong,nonatomic) NSArray *sections;
@end

static NSString *reuserIdentifier = @"settingcell";
@implementation SettingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:reuserIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    ItemModel *item1 = [[ItemModel alloc] init];
    item1.text = @"推送消息";
    item1.accessoryType = ItemAccessoryTypeSwitch;
    item1.execute = ^(){
    
    };
    
    ItemModel *item2 = [[ItemModel alloc] init];
    item2.text = @"给我们打分";
    
    ItemModel *item3 = [[ItemModel alloc] init];
    item3.text = @"意见反馈";
    
    SectionModel *section1 = [[SectionModel alloc] init];
    section1.items = @[item1,item2,item3];
    
    
    //section2
    ItemModel *item5 = [[ItemModel alloc] init];
    item5.text = @"关于简单";
    item5.accessoryType = ItemAccessoryTypeDisclosureIndicator;
    
    ItemModel *item6 = [[ItemModel alloc] init];
    item6.text = @"退出";
    item1.execute = ^(){
        
    };
    
    SectionModel *section2 = [[SectionModel alloc] init];
    section2.items = @[item5,item6];
    
    self.sections = @[section1,section2];

}



#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    SectionModel  *sectionModel = self.sections[section];
    return sectionModel.headerHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    SectionModel  *sectionModel = self.sections[section];
    return sectionModel.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SectionModel *section = self.sections[indexPath.section];
    ItemModel *item = section.items[indexPath.row];
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];
    cell.item = item;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SectionModel *section = self.sections[indexPath.section];
    ItemModel *item = section.items[indexPath.row];
    if (item.execute) {
        item.execute();
    }
}
@end
