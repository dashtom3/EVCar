//
//  OrderTabViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/31.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "OrderTabViewController.h"
#import "RentTabViewCell.h"
#import "OrderDetailViewController.h"
#import "httpRequest.h"
@interface OrderTabViewController (){
    NSArray *data;
    int segmentNumber;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentOrder;




@end

@implementation OrderTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_tableView.tableHeaderView setHidden:YES];
    [_tableView.tableFooterView setHidden:YES];
    
    [_tableView registerNib:[UINib nibWithNibName:@"RentTabViewCell" bundle:nil] forCellReuseIdentifier:@"RentCell"];
    data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@{@"ORDER_NAME":@"暂无",@"RESERVE_STARTTIME":@"",@"type":@"3"}, nil],[NSArray arrayWithObjects:@{@"ORDER_NAME":@"暂无",@"RESERVE_STARTTIME":@"",@"type":@"3"},nil],nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)valueChanged:(id)sender {
    segmentNumber = _segmentOrder.selectedSegmentIndex;
    [_tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self setMainNavBar];
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50, 16, 100, 44)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [labelTitle setFont:[UIFont boldSystemFontOfSize:19]];
    labelTitle.text = @"我的订单";
    self.navigationItem.titleView = labelTitle;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
}
-(void)setData:(NSArray *)orderData{
    NSMutableArray *carOrder = [[NSMutableArray alloc]init];
    NSMutableArray *chargerOrder = [[NSMutableArray alloc]init];
    for(int i=0;i<orderData.count;i++){
        if([[orderData[i] valueForKey:@"ORDER_TYPE"] intValue] == 0){
            [chargerOrder addObject:orderData[i]];
        }else{
            [carOrder addObject:orderData[i]];
        }
    }
    if(!carOrder.count){
        carOrder = [NSMutableArray arrayWithObjects:@{@"ORDER_NAME":@"暂无",@"RESERVE_STARTTIME":@"",@"type":@"3"}, nil];
    }
    if(!chargerOrder.count){
        chargerOrder = [NSMutableArray arrayWithObjects:@{@"ORDER_NAME":@"暂无",@"RESERVE_STARTTIME":@"",@"type":@"3"}, nil];
    }
    data = [NSArray arrayWithObjects:carOrder,chargerOrder, nil];
    [_tableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated{
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    [hr getAllOrders:nil parameters:@{@"userId":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"UserId"],@"token":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"token"]} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            [self setData:[responseObject valueForKey:@"userOrders"]];
        }else{
            [self showAlertView:@"获取订单信息失败"];
        }
    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"获取订单信息失败"];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)data[segmentNumber]).count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RentTabViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentCell"];
    if(cell){
        NSString *image = segmentNumber != 1 ? @"main_map_rent" : @"main_map_rent2" ;
        if(((NSString *)[data[segmentNumber][indexPath.row] valueForKey:@"RESERVE_STARTTIME"]).length >5){
        [cell setValueWithImage:image WithTitle:[data[segmentNumber][indexPath.row] valueForKey:@"ORDER_NAME"] WithDetail:[[data[segmentNumber][indexPath.row] valueForKey:@"RESERVE_STARTTIME"] substringToIndex:10]];
        }else{
            [cell setValueWithImage:image WithTitle:[data[segmentNumber][indexPath.row] valueForKey:@"ORDER_NAME"] WithDetail:[data[segmentNumber][indexPath.row] valueForKey:@"RESERVE_STARTTIME"]];
        }
        //[cell setRentState:[data[segmentNumber][indexPath.row] valueForKey:@"type"]];
        [cell setRentState:@"3"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([data[segmentNumber][indexPath.row] valueForKey:@"USER_ID"]){
        OrderDetailViewController *odvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"orderDetail"];
        [odvc setDataSet:data[segmentNumber][indexPath.row]];
        odvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:odvc animated:YES];
         odvc.hidesBottomBarWhenPushed = NO;
    }
}
@end
