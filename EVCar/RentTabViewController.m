//
//  RentTabViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentTabViewController.h"
#import "RentTabViewCell.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "RentViewController.h"
#import "SearchViewController.h"
@interface RentTabViewController (){
    NSArray *data;
    BMKMapManager* _mapManager;
    BMKMapView *mapView2;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation RentTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setInit{
    [super setInit];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"base_remind_no"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50, 16, 100, 44)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [labelTitle setFont:[UIFont boldSystemFontOfSize:19]];
    labelTitle.attributedText = [self stringChange:@"ECAR" Color:[UIColor MainColor] Range:NSMakeRange(0, 1)];
    self.navigationItem.titleView = labelTitle;
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"YEe2UHUP7lkVqGPZwh5OquCp"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    mapView2 = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 242)];
    [self.view addSubview:mapView2];
    mapView2.delegate = self;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView.tableHeaderView setHidden:YES];
    [_tableView.tableFooterView setHidden:YES];

    [_tableView registerNib:[UINib nibWithNibName:@"RentTabViewCell" bundle:nil] forCellReuseIdentifier:@"RentCell"];
    data = [NSArray arrayWithObjects:@{@"image":@"main_map_rent",@"title":@"同济大学四平路校区",@"detail":@"距离您最近的租赁点"}, @{@"image":@"main_map_rent2",@"title":@"静安希尔顿酒店",@"detail":@"距离您最近的充电桩"}, @{@"image":@"main_map_search",@"title":@"查找更多租赁点或充电桩"},nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setMainNavBar];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RentTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentCell"];
    if(cell){
        
        [cell setValueWithImage:[data[indexPath.row] valueForKey:@"image"] WithTitle:[data[indexPath.row] valueForKey:@"title"] WithDetail:[data[indexPath.row] valueForKey:@"detail"]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 0){
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"rentView"] animated:YES];
    }else if(indexPath.row == 1){
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"rentView"] animated:YES];
    }else{
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"] animated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
