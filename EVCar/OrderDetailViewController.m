//
//  OrderDetailViewController.m
//  EVCar
//
//  Created by 田程元 on 15/12/29.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController (){
    NSArray *data;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@{@"title":@"车辆信息",@"detail":@"荣威E50"},nil],[NSArray arrayWithObjects:@{@"title":@"取车时间",@"detail":@"10-26 09:06"},@{@"title":@"还车时间",@"detail":@"10-26 11:05"},nil],[NSArray arrayWithObjects:@{@"title":@"卡号",@"detail":@"145009811"},@{@"title":@"订单编号",@"detail":@"荣C2015102600010049"},@{@"title":@"订单状态",@"detail":@"已支付"},@{@"title":@"订单日期",@"detail":@"10-26 09：00"},@{@"title":@"租车金额",@"detail":@"￥31.5"},@{@"title":@"违章信息",@"detail":@"无违章"},nil], nil];
    // Do any additional setup after loading the view.
}
-(void)setInit{
    [super setInit];
    
    //_data = [NSArray arrayWithObjects:@{},@{},@{},nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self setOrderDetailNavBar];
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
    return data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)data[section]).count;
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
        cell.textLabel.text = [data[indexPath.section][indexPath.row] valueForKey:@"title"];
        cell.detailTextLabel.text = [data[indexPath.section][indexPath.row] valueForKey:@"detail"];
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
