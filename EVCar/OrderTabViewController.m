//
//  OrderTabViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/31.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "OrderTabViewController.h"
#import "RentTabViewCell.h"
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
    data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@{@"title":@"沪DT2010",@"detail":@"2015年10月24日",@"type":@"1"}, @{@"title":@"沪DT2010",@"detail":@"2015年10月30日",@"type":@"0"}, @{@"title":@"沪DT2010",@"detail":@"2015年10月25日",@"type":@"2"}, nil],[NSArray arrayWithObjects:@{@"title":@"充电桩2014",@"detail":@"2015年10月25日",@"type":@"2"}, @{@"title":@"充电桩2022",@"detail":@"2015年10月25日",@"type":@"0"}, @{@"title":@"充电桩1014",@"detail":@"2015年10月25日",@"type":@"0"}, @{@"title":@"充电桩1014",@"detail":@"2015年10月23日",@"type":@"1"},nil],nil];
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
    self.title = @"我的订单";
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
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
        [cell setValueWithImage:image WithTitle:[data[segmentNumber][indexPath.row] valueForKey:@"title"] WithDetail:[data[segmentNumber][indexPath.row] valueForKey:@"detail"]];
        [cell setRentState:[data[segmentNumber][indexPath.row] valueForKey:@"type"]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
@end
