//
//  UserTabViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "UserTabViewController.h"
#import "RentViewCell.h"
@interface UserTabViewController (){
    NSArray *data;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation UserTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [self setMainNavBar];
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width-50, 16, 100, 44)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [labelTitle setFont:[UIFont boldSystemFontOfSize:19]];
    labelTitle.text = @"个人";
    self.navigationItem.titleView = labelTitle;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
}
- (void)viewWillAppear:(BOOL)animated{
    data = [NSArray arrayWithObjects:[NSArray arrayWithObjects:@{@"image":@"user_recharge",@"title":@"E币充值"},@{@"image":@"user_deposit",@"title":@"押金"}, nil], [NSArray arrayWithObjects:@{@"image":@"user_help",@"title":@"帮助中心",@"detail":@""},@{@"image":@"user_activity",@"title":@"活动",@"detail":@""} ,nil],[NSArray arrayWithObjects:@{@"image":@"user_setting",@"title":@"系统设置",@"detail":@""},nil],nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setInit{
    [super setInit];
    [_tableView.tableHeaderView setHidden:YES];
    [_tableView.tableFooterView setHidden:YES];
    [_tableView registerNib:[UINib nibWithNibName:@"RentViewCell" bundle:nil] forCellReuseIdentifier:@"RentViewCell"];
    _tableView.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
    [self setNavgationControllerLine];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return data.count+2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == data.count+1){
        return 1;
    }
    return ((NSArray *)data[section-1]).count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01f)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    if(indexPath.section == 0){
        return 84;
    }
    return 48.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1
                                                          reuseIdentifier:@"cell"];
    if(cell){
        //注销按钮
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator ;
        if(indexPath.section == data.count+1){
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
            [btn setTitle:@"注销" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor MainColor]];
            [btn addTarget:self action:@selector(backToLoginView) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
        //个人
        }else if(indexPath.section == 0){
            UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(8,11, 62, 62)];
            [view setImage:[UIImage imageNamed:@"user_image"]];
            view.contentMode = UIViewContentModeScaleAspectFit;
            [cell addSubview:view];
            UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(78, 0, 250, 84)];
            lbl.text = [[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"username"];
            [cell addSubview:lbl];
        }else{
//            RentViewCell *cell1 = [_tableView dequeueReusableCellWithIdentifier:@"RentViewCell"];
//            [cell1 setImage:[data[indexPath.section-1][indexPath.row] valueForKey:@"image"] Title:[data[indexPath.section-1][indexPath.row] valueForKey:@"title"] Detail:@"" Type:0];
//            return cell1;
            cell.imageView.image = [UIImage imageNamed:[data[indexPath.section-1][indexPath.row] valueForKey:@"image"]];
            cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
            cell.textLabel.text = [data[indexPath.section-1][indexPath.row] valueForKey:@"title"];
        }
    }
    return cell;
}
-(void)backToLoginView{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 0){
        
    }else if(indexPath.row == 0 && indexPath.section == 2){
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"userHelp"] animated:YES];
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
