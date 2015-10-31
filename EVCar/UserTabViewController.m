//
//  UserTabViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "UserTabViewController.h"

@interface UserTabViewController (){
    NSArray *data;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView.tableHeaderView setHidden:YES];
    [_tableView.tableFooterView setHidden:YES];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self setMainNavBar];
    self.title = @"个人";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@{@"title":@"个人信息",@"detail":@"田程元"}, nil], [NSArray arrayWithObjects:@{@"title":@"总计订单",@"detail":@"8次"},@{@"title":@"总计租金",@"detail":@"￥249"} ,nil],[NSArray arrayWithObjects:@{@"title":@"E币剩余",@"detail":@"￥0.0"}, @{@"title":@"押金",@"detail":@"￥1000"},nil],nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setInit{
    [super setInit];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return data.count+1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == data.count){
        return 1;
    }
    return ((NSArray *)data[section]).count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    return 48.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                          reuseIdentifier:@"cell"];
    if(cell){
        if(indexPath.section == data.count){
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
            [btn setTitle:@"注销" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor MainColor]];
            [btn addTarget:self action:@selector(backToLoginView) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        }else{
            cell.textLabel.text = [data[indexPath.section][indexPath.row] valueForKey:@"title"];
            cell.detailTextLabel.text = [data[indexPath.section][indexPath.row] valueForKey:@"detail"];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        }
    }
    return cell;
}
-(void)backToLoginView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
