//
//  OrderDetailViewController.m
//  EVCar
//
//  Created by 田程元 on 15/12/29.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "httpRequest.h"
@interface OrderDetailViewController (){
    int stateType;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *btnPayOrder;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _btnPayOrder.layer.cornerRadius = 6.0f;
    // Do any additional setup after loading the view.
    
}
-(void)setInit{
    [super setInit];
    
    //_data = [NSArray arrayWithObjects:@{},@{},@{},nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self setOrderDetailNavBar];
    if(stateType == 0){
        _btnPayOrder.alpha = 1.0;
    }else{
        _btnPayOrder.alpha = 0.0;
    }
}
- (IBAction)payOrder:(id)sender {
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    [hr getAllOrders:nil parameters:@{@"userId":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"UserId"],@"token":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"token"]} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            [self showAlertView:@"支付成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showAlertView:@"支付失败"];
        }
    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"支付失败"];
    }];

}
-(void)setDataSet:(NSMutableDictionary *)dataSet{
    NSString *state;
    stateType = [[dataSet valueForKey:@"ORDER_STATE"] intValue];
    if([[dataSet valueForKey:@"ORDER_STATE"] intValue] == 0){
        state = @"未支付";
    }else if([[dataSet valueForKey:@"ORDER_STATE"] intValue] == 1){
        state = @"已支付";
    }else if([[dataSet valueForKey:@"ORDER_STATE"] intValue] == 2){
        state = @"已取消";
    }else {
        state = @"已完成";
    }
    if([[dataSet valueForKey:@"ORDER_TYPE"] intValue] == 0){
        _data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@{@"title":@"充电桩信息",@"detail":[dataSet valueForKey:@"ORDER_NAME"]},nil],[NSArray arrayWithObjects:@{@"title":@"充电时间",@"detail":[dataSet valueForKey:@"RESERVE_STARTTIME"]},@{@"title":@"归还时间",@"detail":[dataSet valueForKey:@"LATEST_TIME"]},nil],[NSArray arrayWithObjects:@{@"title":@"卡号",@"detail":@"145009811"},@{@"title":@"订单编号",@"detail":[dataSet valueForKey:@"ORDER_ID"]},@{@"title":@"订单状态",@"detail":state},@{@"title":@"订单日期",@"detail":[dataSet valueForKey:@"LATEST_TIME"]},@{@"title":@"充电金额",@"detail":[dataSet valueForKey:@"TOTAL_PRICE"]},nil], nil];
    }else{
        
        _data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@{@"title":@"车辆信息",@"detail":[dataSet valueForKey:@"ORDER_NAME"]},nil],[NSArray arrayWithObjects:@{@"title":@"取车时间",@"detail":[dataSet valueForKey:@"RESERVE_STARTTIME"]},@{@"title":@"还车时间",@"detail":[dataSet valueForKey:@"LATEST_TIME"]},nil],[NSArray arrayWithObjects:@{@"title":@"卡号",@"detail":@"145009811"},@{@"title":@"订单编号",@"detail":[dataSet valueForKey:@"ORDER_ID"]},@{@"title":@"订单状态",@"detail":state},@{@"title":@"订单日期",@"detail":[dataSet valueForKey:@"LATEST_TIME"]},@{@"title":@"租车金额",@"detail":[NSString stringWithFormat:@"%@",(NSNumber *)[dataSet valueForKey:@"TOTAL_PRICE"]] },@{@"title":@"违章信息",@"detail":@"无违章"},nil], nil];
    }
   
}
-(void)setOrderDetailNavBar{
    [self.navigationController setNavigationBarHidden:false];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"base_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMainView)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.title = @"订单详情";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor MainColor]];
    [self setNavgationControllerLine];
    //[self hideTabBar];
}
-(void)backToMainView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)_data[section]).count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    return 48;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                   reuseIdentifier:@"cell"];
    if(cell){
        cell.textLabel.text = [_data[indexPath.section][indexPath.row] valueForKey:@"title"];
        cell.detailTextLabel.text = [_data[indexPath.section][indexPath.row] valueForKey:@"detail"];
    }
    return cell;
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
