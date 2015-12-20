//
//  UserHelpViewController.m
//  EVCar
//
//  Created by 田程元 on 15/12/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "UserHelpViewController.h"
#import "WebViewController.h"
@interface UserHelpViewController (){
    NSArray *data;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    // Do any additional setup after loading the view.
    data = [NSArray arrayWithObjects:@"会员注册",@"预订车辆",@"订单支付",@"新手上路",@"及非规则",@"充电须知",@"保障服务",@"常见问题", nil];
}
-(void)setInit{
    [super setInit];
    
    //_data = [NSArray arrayWithObjects:@{},@{},@{},nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self setHelpNavBar];
}
-(void)setHelpNavBar{
    [self.navigationController setNavigationBarHidden:false];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"base_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMainView)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.title = @"帮助中心";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor MainColor]];
    [self setNavgationControllerLine];
    [self hideTabBar];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    if(section == 1){
//        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01f)];
//    }
//    return nil;
//}
-(void)backToMainView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                   reuseIdentifier:@"cell"];
    if(cell){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = data[indexPath.row];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WebViewController *wvc =[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"webView" ];
    wvc.webTitle = data[indexPath.row];
    [self.navigationController pushViewController:wvc animated:YES];
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
