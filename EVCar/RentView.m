//
//  RentView.m
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentView.h"
#import "RentViewCell.h"
#import "CarView.h"
@implementation RentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"RentViewCell" bundle:nil] forCellReuseIdentifier:@"RentViewCell"];
    _data = [NSArray arrayWithObjects:@{@"image":@"car_name",@"title":@"车辆型号",@"detail":@"启辰T70"}, @{@"image":@"car_distance",@"title":@"续航里程",@"detail":@"21公里"}, @{@"image":@"car_number",@"title":@"车牌号",@"detail":@"沪FY0676"},@{@"image":@"car_times",@"title":@"租借次数",@"detail":@"19 次"},nil];
}
- (IBAction)rentCar:(id)sender {
    [_delegate showAlertView:_data];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    return 60.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CarView *view = [[[NSBundle mainBundle] loadNibNamed:@"CarView" owner:nil options:nil] firstObject];
    view.frame = CGRectMake(0, 0, self.frame.size.width, 242);
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 212;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentViewCell"];
    if(cell){
        if(indexPath.row == 0 || indexPath.row == 3){
            [cell setImage:[_data[indexPath.row] valueForKey:@"image"] Title:[_data[indexPath.row] valueForKey:@"title"] Detail:[_data[indexPath.row] valueForKey:@"detail"] Type:0];
        }else{
            [cell setImage:[_data[indexPath.row] valueForKey:@"image"] Title:[_data[indexPath.row] valueForKey:@"title"] Detail:[_data[indexPath.row] valueForKey:@"detail"] Type:1];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 2){
        
    }
}

@end
