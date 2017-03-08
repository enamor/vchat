//
//  LKProvinceViewController.m
//  ChinaRegionDemo
//
//  Created by zhouen on 16/8/31.
//  Copyright © 2016年 zhouen. All rights reserved.
//

#import "LKProvinceViewController.h"
#import "LKCityViewController.h"
#import "LKAreaViewController.h"
#import "LKProvince.h"
#import "LKCity.h"
#import "MJExtension.h"

@interface LKProvinceViewController ()
@property (strong,nonatomic) NSArray *provinces;
@end

static NSString *reuserIdentifier = @"provinceCell";
@implementation LKProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"省";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuserIdentifier];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    _provinces = [NSMutableArray array];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"China_region" ofType:@"plist"];
    NSArray *regions = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSArray *userArray = [LKProvince mj_objectArrayWithKeyValuesArray:regions];
    self.provinces = [NSArray arrayWithArray:userArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.provinces.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIdentifier forIndexPath:indexPath];
    
    LKProvince *pro = self.provinces[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = pro.provinceName;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LKProvince *pro = self.provinces[indexPath.row];
    if (indexPath.row < 4) {
        LKAreaViewController *areaVC = [[LKAreaViewController alloc] init];
        areaVC.province = pro;
        areaVC.city = pro.citys[0];
        [self.navigationController pushViewController:areaVC animated:YES];
    }else{
        LKCityViewController *cityVC = [[LKCityViewController alloc] init];
        cityVC.province = pro;
        [self.navigationController pushViewController:cityVC animated:YES];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
