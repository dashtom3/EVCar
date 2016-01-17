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
#import "CarPointAnnotation.h"
#import "ChargerPointAnnotation.h"
@interface RentTabViewController (){
    NSMutableArray *data;
    NSMutableArray *mapCarData;
    NSMutableArray *mapChargerData;
    NSMutableDictionary *mapCarNear;
    NSMutableDictionary *mapChargerNear;
    BMKMapManager* _mapManager;
    BMKMapView *mapView2;
    BMKLocationService* locService;
    BMKUserLocation *userLocate;
    Boolean mapLocationFirstUpdate;
    BMKPointAnnotation *selectedAnnotation;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *btnRentOrder;



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
    data = [NSMutableArray arrayWithObjects:@{@"image":@"main_map_rent",@"title":@"暂无",@"detail":@"距离您最近的租赁点"}, @{@"image":@"main_map_rent2",@"title":@"暂无",@"detail":@"距离您最近的充电桩"}, @{@"image":@"main_map_search",@"title":@"查找更多租赁点或充电桩"},nil];
    
    _btnRentOrder.layer.cornerRadius = 6.0f;
    _btnRentOrder.layer.borderWidth = 1;
    _btnRentOrder.layer.borderColor = [UIColor borderColor2].CGColor;
    [self.view bringSubviewToFront:_btnRentOrder];
}

-(void)viewDidAppear:(BOOL)animated{
    [self startLocation];
    [self setNavgationControllerLineShow];
    [self getChargerInfo];
}
- (void)viewWillAppear:(BOOL)animated{
    [self setMainNavBar];
    mapLocationFirstUpdate = true;
    mapView2.delegate = self;
    locService.delegate = self;
    if(selectedAnnotation){
        _btnRentOrder.alpha = 1.0;
    }else{
        _btnRentOrder.alpha = 0.0;
    }
    
}
-(void)startLocation{
    [locService startUserLocationService];
    mapView2.showsUserLocation = NO;//先关闭显示的定位图层
    mapView2.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    mapView2.showsUserLocation = YES;//显示定位图层
}
//获取所有车点、桩点信息
- (IBAction)rentOrder:(id)sender {
    if(selectedAnnotation){
        if([selectedAnnotation isKindOfClass:[ChargerPointAnnotation class]]){
            PileViewController *pvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"pileView"];
            pvc.data = ((ChargerPointAnnotation *)selectedAnnotation).data;
            pvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: pvc animated:YES];
            pvc.hidesBottomBarWhenPushed = NO;
        }
        if([selectedAnnotation isKindOfClass:[CarPointAnnotation class]]){
            [self goToCarViews:((CarPointAnnotation *)selectedAnnotation).data];
        }
    }
    
}
-(void)goToCarViews:(NSMutableDictionary *)carData{
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    [hr getAlllCarInParkInfo:nil parameters:@{@"userId":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"UserId"],@"token":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"token"],@"regionId":[carData valueForKey:@"locationId"]} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            NSData *data2 = [[responseObject valueForKey:@"evCarInfo"] dataUsingEncoding :NSUTF8StringEncoding];
            NSArray *jsonData = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
            if(jsonData.count<1){
                [self showAlertView:@"该租车点没有可租汽车"];
            }else {
                RentViewController *rvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"rentView"];
                rvc.data = [NSMutableDictionary dictionaryWithDictionary:@{@"title":carData,@"data":jsonData}];
                rvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController: rvc animated:YES];
                rvc.hidesBottomBarWhenPushed = NO;
            }
        }else{
            [self showAlertView:@"获取汽车信息失败"];
        }
    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"获取汽车信息失败"];
    }];

}
-(void)getChargerInfo{
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    [hr getAllChargerParkInfo:nil parameters:nil success:^(id responseObject) {
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            mapChargerData = [responseObject valueForKey:@"terminals"];
            if(userLocate){
                [self setMapNearWithType:0];
            }
            //画到地图上
            for(int i=0;i<mapChargerData.count;i++){
                if([mapChargerData[i] valueForKey:@"Lat"] != [NSNull null]){
                    ChargerPointAnnotation * annotation = [[ChargerPointAnnotation alloc]init];
                    CLLocationCoordinate2D coor;
                    coor.latitude = [[mapChargerData[i] valueForKey:@"Lat"] floatValue];
                    coor.longitude = [[mapChargerData[i] valueForKey:@"Lng"] floatValue];
                    annotation.coordinate = coor;
                    annotation.data = mapChargerData[i];
                    annotation.title = [NSString stringWithFormat:@"%@",[mapChargerData[i] valueForKey:@"TerminalName"]];
                    [mapView2 addAnnotation:annotation];
                }
            }
            [hr getAllCarParkInfo:nil parameters:@{@"userId":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"UserId"],@"token":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"token"]} success:^(id responseObject) {
                [self.waitingAnimation stopAnimation];
                if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
                    
                    NSData *data2 = [[responseObject valueForKey:@"evCarLocation"] dataUsingEncoding :NSUTF8StringEncoding];
                    mapCarData = [NSJSONSerialization JSONObjectWithData:data2 options:NSJSONReadingMutableContainers error:nil];
                    
                    if(userLocate){
                        [self setMapNearWithType:1];
                    }
                    //画到地图上
                    for(int i=0;i<mapCarData.count;i++){
                        if([mapCarData[i] valueForKey:@"latitude"] != [NSNull null]){
                            CarPointAnnotation * annotation = [[CarPointAnnotation alloc]init];
                            CLLocationCoordinate2D coor;
                            coor.latitude = [[mapCarData[i] valueForKey:@"latitude"] floatValue];
                            coor.longitude = [[mapCarData[i] valueForKey:@"longitude"] floatValue];
                            annotation.coordinate = coor;
                            annotation.data = mapCarData[i];
                            annotation.title = [NSString stringWithFormat:@"%@",[mapCarData[i] valueForKey:@"locationName"]];
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
-(void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    if([view.annotation isKindOfClass:[CarPointAnnotation class]]){
        if([[((CarPointAnnotation *)view.annotation).data valueForKey:@"status"] intValue]==1){
            _btnRentOrder.alpha = 1.0;
            [self.view bringSubviewToFront:_btnRentOrder];
            selectedAnnotation = view.annotation;
        }else{
            _btnRentOrder.alpha = 0.0;
        }
        
    }
    if([view.annotation isKindOfClass:[ChargerPointAnnotation class]]){
        if([[((ChargerPointAnnotation *)view.annotation).data valueForKey:@"TerminalState"] intValue]==1){
            _btnRentOrder.alpha = 1.0;
            [self.view bringSubviewToFront:_btnRentOrder];
            selectedAnnotation = view.annotation;
        }else{
            _btnRentOrder.alpha = 0.0;
        }
    }
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[ChargerPointAnnotation class]]) {
//    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        if(((CarPointAnnotation *)annotation).data){
            NSMutableDictionary *data2 = ((CarPointAnnotation *)annotation).data;
            if([[data2 valueForKey:@"TerminalState"] intValue] == 1){
                newAnnotationView.image = [UIImage imageNamed:@"charger_yes"];
            }else{
                newAnnotationView.image = [UIImage imageNamed:@"charger_no"];
            }
        }
        return newAnnotationView;
    }
    if ([annotation isKindOfClass:[CarPointAnnotation class]]) {
        //    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *newAnnotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
        newAnnotationView.pinColor = BMKPinAnnotationColorPurple;
        newAnnotationView.animatesDrop = YES;// 设置该标注点动画显示
        if(((CarPointAnnotation *)annotation).data){
            NSMutableDictionary *data2 = ((CarPointAnnotation *)annotation).data;
            if([[data2 valueForKey:@"status"] intValue] == 1){
                newAnnotationView.image = [UIImage imageNamed:@"car_yes"];
            }else{
                newAnnotationView.image = [UIImage imageNamed:@"car_no"];
            }
        }
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
        if([[mapCarNear valueForKey:@"status"] intValue] == 1){
            [self goToCarViews:mapCarNear];
        }else{
            [self showAlertView:@"最近的租车点已不可用,详情请查看地图"];
        }
        
    }else if(indexPath.row == 1){
        if([[mapChargerNear valueForKey:@"TerminalState"] intValue] == 1){
            PileViewController *pvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"pileView"];
            pvc.data = mapChargerNear;
            pvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController: pvc animated:YES];
            pvc.hidesBottomBarWhenPushed = NO;
        }else{
            [self showAlertView:@"最近的充电桩已不可用,详情请查看地图"];
        }
    }else{
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"searchView"] animated:YES];
    }
}
//计算距离
-(float)getDistanceWithX1:(float) x1 Y1:(float) y1 X2:(float) x2 Y2:(float) y2{
    return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
}
//得到最近的点
-(NSMutableDictionary *)getNearWithLat:(float) lat WithLng:(float) lng WithType:(int )type{
    float minimun = -1;
    NSMutableDictionary * result;
    if(type==0){
    for(int i=0;i<mapChargerData.count;i++){
        if([mapChargerData[i] valueForKey:@"Lat"] && (NSNull *)[mapChargerData[i] valueForKey:@"Lat"] != [NSNull null]){
            float dis = [self getDistanceWithX1:[[mapChargerData[i] valueForKey:@"Lat"] floatValue] Y1:[[mapChargerData[i] valueForKey:@"Lng"] floatValue] X2:lat Y2:lng];
            if(minimun == -1 || dis < minimun){
                result = mapChargerData[i];
                minimun = dis;
            }
        }
    }
    }else{
        for(int i=0;i<mapCarData.count;i++){
            if([mapCarData[i] valueForKey:@"latitude"] && (NSNull *)[mapCarData[i] valueForKey:@"latitude"] != [NSNull null]){
                float dis = [self getDistanceWithX1:[[mapCarData[i] valueForKey:@"latitude"] floatValue] Y1:[[mapCarData[i] valueForKey:@"longitude"] floatValue] X2:lat Y2:lng];
                if(minimun == -1 || dis < minimun){
                    result = mapCarData[i];
                    minimun = dis;
                }
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
    if(mapChargerData){
        [self setMapNearWithType:0];
    }
    if(mapCarData){
        [self setMapNearWithType:1];
    }
    if(mapLocationFirstUpdate == true){
        [mapView2 setCenterCoordinate:userLocation.location.coordinate];
        mapLocationFirstUpdate = false;
    }
}
-(void)setMapNearWithType:(int)type{
    if(type==0){
        mapChargerNear = [self getNearWithLat:userLocate.location.coordinate.latitude WithLng:userLocate.location.coordinate.longitude WithType:type];
        NSMutableDictionary *b = [data[1] mutableCopy];
        [b setObject:[mapChargerNear valueForKey:@"TerminalName"] forKey:@"title"];
        [data removeObjectAtIndex:1];
        [data insertObject:b atIndex:1];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }else{
        mapCarNear = [self getNearWithLat:userLocate.location.coordinate.latitude WithLng:userLocate.location.coordinate.longitude WithType:type];
        NSMutableDictionary *b = [data[0] mutableCopy];
        [b setObject:[mapCarNear valueForKey:@"locationName"] forKey:@"title"];
        [data removeObjectAtIndex:0];
        [data insertObject:b atIndex:0];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
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
