//
//  RentView.h
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//
@protocol carAlertViewDelegate

-(void)showAlertView:(NSArray *)data;

@end
#import <UIKit/UIKit.h>

@interface RentView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *data;
@property (strong, nonatomic) IBOutlet UIButton *btnRent;

@property (nonatomic) id delegate;
@end