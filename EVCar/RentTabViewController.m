//
//  RentTabViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentTabViewController.h"
#import "RentTabViewCell.h"

#import "RentViewController.h"
#import "SearchViewController.h"
@interface RentTabViewController (){
    NSArray *data;
    BMKMapManager* _mapManager;
    BMKMapView *mapView2;
    BMKLocationService* locService;
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
    labelTitle.attributedText = [self stringChange:@"惠易租" Color:[UIColor MainColor] Range:NSMakeRange(0, 1)];
    self.navigationItem.titleView = labelTitle;
    
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"YEe2UHUP7lkVqGPZwh5OquCp"  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    mapView2 = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 242)];
    [self.view addSubview:mapView2];
    [mapView2 setZoomEnabled:YES];
    [mapView2 setZoomLevel:13];
    locService = [[BMKLocationService alloc]init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView.tableHeaderView setHidden:YES];
    [_tableView.tableFooterView setHidden:YES];

    [_tableView registerNib:[UINib nibWithNibName:@"RentTabViewCell" bundle:nil] forCellReuseIdentifier:@"RentCell"];
    data = [NSArray arrayWithObjects:@{@"image":@"main_map_rent",@"title":@"同济大学四平路校区",@"detail":@"距离您最近的租赁点"}, @{@"image":@"main_map_rent2",@"title":@"静安希尔顿酒店",@"detail":@"距离您最近的充电桩"}, @{@"image":@"main_map_search",@"title":@"查找更多租赁点或充电桩"},nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [self setMainNavBar];
    
    [self startLocation];
    [self setNavgationControllerLineShow];
}
- (void)viewWillAppear:(BOOL)animated{
    mapView2.delegate = self;
    locService.delegate = self;
}
-(void)startLocation{
    [locService startUserLocationService];
    mapView2.showsUserLocation = NO;//先关闭显示的定位图层
    mapView2.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    mapView2.showsUserLocation = YES;//显示定位图层
}
- (void)viewDidDisappear:(BOOL)animated{
    mapView2.delegate = nil;
    locService.delegate = nil;
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
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"pileView"] animated:YES];
    }else{
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"] animated:YES];
    }
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [mapView2 updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [mapView2 updateLocationData:userLocation];
    [mapView2 setCenterCoordinate:userLocation.location.coordinate];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
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
