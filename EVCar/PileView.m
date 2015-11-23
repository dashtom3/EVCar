//
//  PileView.m
//  EVCar
//
//  Created by 田程元 on 15/11/23.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PileView.h"
#import "RentViewCell.h"
@implementation PileView
- (void)awakeFromNib{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"RentViewCell" bundle:nil] forCellReuseIdentifier:@"RentViewCell"];
    _data = [NSArray arrayWithObjects:@{@"image":@"pile_wait",@"title":@"前方等待",@"detail":@"9 辆"}, nil];
}
- (IBAction)rentCar:(id)sender {
    [_delegate showAlertView:_data];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.section,根据分组进行更精确的配置
    return 60.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 242)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2-100, 10, 200, 232)];
    [imageView setImage:[UIImage imageNamed:@"pile_pile"]];
    imageView.contentMode = UIViewContentModeScaleAspectFit ;
    [view addSubview:imageView];
    view.layer.masksToBounds = YES;
    [view setBackgroundColor:[UIColor BackgroundBlueColor]];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 212;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RentViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RentViewCell"];
    if(cell){
            [cell setImage:[_data[indexPath.row] valueForKey:@"image"] Title:[_data[indexPath.row] valueForKey:@"title"] Detail:[_data[indexPath.row] valueForKey:@"detail"] Type:0];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 2){
        
    }
}

@end
