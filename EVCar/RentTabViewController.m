//
//  RentTabViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentTabViewController.h"
#import "RentTabViewCell.h"
#import "httpRequest.h"
#import "RentViewController.h"
#import "SearchViewController.h"
#import "PileViewController.h"
@interface RentTabViewController (){
    NSMutableArray *data;
    NSMutableArray *mapData;
    NSMutableDictionary *mapNear;
    BMKMapManager* _mapManager;
    BMKMapView *mapView2;
    BMKLocationService* locService;
    BMKUserLocation *userLocate;
    Boolean mapLocationFirstUpdate;
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
    mapView2 = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-300)];
    [self.view addSubview:mapView2];
    [mapView2 setZoomEnabled:YES];
    [mapView2 setZoomLevel:13];
    locService = [[BMKLocationService alloc]init];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView.tableHeaderView setHidden:YES];
    [_tableView.tableFooterView setHidden:YES];

    [_tableView registerNib:[UINib nibWithNibName:@"RentTabViewCell" bundle:nil] forCellReuseIdentifier:@"RentCell"];
    data = [NSMutableArray arrayWithObjects:@{@"image":@"main_map_rent",@"title":@"暂无",@"detail":@"距离您最近的租赁点"}, @{@"image":@"main_map_rent2",@"title":@"",@"detail":@"距离您最近的充电桩"}, @{@"image":@"main_map_search",@"title":@"查找更多租赁点或充电桩"},nil];
}

-(void)viewDidAppear:(BOOL)animated{
    
    
    [self startLocation];
    [self setNavgationControllerLineShow];
    //[self getCarInfo];
    [self getChargerInfo];
}
- (void)viewWillAppear:(BOOL)animated{
    [self setMainNavBar];
    mapLocationFirstUpdate = true;
    mapView2.delegate = self;
    locService.delegate = self;
}
-(void)startLocation{
    [locService startUserLocationService];
    mapView2.showsUserLocation = NO;//先关闭显示的定位图层
    mapView2.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    mapView2.showsUserLocation = YES;//显示定位图层
}
//获取所有车点、桩点信息
-(void)getCarInfo{
    httpRequest *hr = [[httpRequest alloc]init];
    [hr getAllCarPark:nil parameters:@{@"userId":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"UserId"],@"token":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"token"]} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            
        }else{
            [self showAlertView:@"获取租车点信息失败"];
        }

    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"获取租车点信息失败"];
    }];
}
-(void)getChargerInfo{
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    [hr getAllChargerParkInfo:nil parameters:nil success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            mapData = [responseObject valueForKey:@"terminals"];
            if(userLocate){
                [self setMapNear];
            }
            //画到地图上
            for(int i=0;i<mapData.count;i++){
                if([mapData[i] valueForKey:@"Lat"] != [NSNull null]){
                    BMKPointAnnotation* annotation = [[BMKPointAnnotation alloc]init];
                    CLLocationCoordinate2D coor;
                    coor.latitude = [[mapData[i] valueForKey:@"Lat"] floatValue];
                    coor.longitude = [[mapData[i] valueForKey:@"Lng"] floatValue];
                    annotation.coordinate = coor;
                    NSString *li = @"不可用";
                    if([[mapData[i] valueForKey:@"TerminalState"] intValue] == 1){
                         li= @"可用";
                    }
                    annotation.title = [NSString stringWithFormat:@"%@ %@",[mapData[i] valueForKey:@"TerminalName"] , li];
                    [mapView2 addAnnotation:annotation];
                }
            }
        }else{
            [self showAlertView:@"获取租车点信息失败"];
        }
    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"获取租车点信息失败"];
    }];
}
- (void)viewDidDisappear:(BOOL)animated{
    mapView2.delegate = nil;
    locService.delegate = nil;
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        return newAnnotationView;
    }
    return nil;
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
        PileViewController *pvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"pileView"];
        pvc.data = mapNear;
        pvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController: pvc animated:YES];
        pvc.hidesBottomBarWhenPushed = NO;
    }else{
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"] animated:YES];
    }
}
//计算距离
-(float)getDistanceWithX1:(float) x1 Y1:(float) y1 X2:(float) x2 Y2:(float) y2{
    return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
}
//得到最近的点
-(NSDictionary *)getNearWithLat:(float) lat WithLng:(float) lng{
    float minimun = -1;
    NSDictionary * result;
    for(int i=0;i<mapData.count;i++){
        if([mapData[i] valueForKey:@"Lat"] && (NSNull *)[mapData[i] valueForKey:@"Lat"] != [NSNull null]){
            float dis = [self getDistanceWithX1:[[mapData[i] valueForKey:@"Lat"] floatValue] Y1:[[mapData[i] valueForKey:@"Lng"] floatValue] X2:lat Y2:lng];
            if(minimun == -1 || dis < minimun){
                result = mapData[i];
                minimun = dis;
            }
        }
    }
    return result;
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
    userLocate = userLocation;
    if(mapData){
        [self setMapNear];
    }
    if(mapLocationFirstUpdate == true){
        [mapView2 setCenterCoordinate:userLocation.location.coordinate];
        mapLocationFirstUpdate = false;
    }
}
-(void)setMapNear{
    mapNear = [self getNearWithLat:userLocate.location.coordinate.latitude WithLng:userLocate.location.coordinate.longitude];
    NSMutableDictionary *b = [data[1] mutableCopy];
    [b setObject:[mapNear valueForKey:@"TerminalName"] forKey:@"title"];
    [data removeObjectAtIndex:1];
    [data insertObject:b atIndex:1];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
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
    [self startLocation];
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
