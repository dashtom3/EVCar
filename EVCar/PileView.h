//
//  PileView.h
//  EVCar
//
//  Created by 田程元 on 15/11/23.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//
@protocol  pileAlertViewDelegate

-(void)showAlertView:(NSArray *)data;

@end
#import <UIKit/UIKit.h>

@interface PileView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *data;
@property (strong, nonatomic) IBOutlet UIButton *btnPile;

@property (nonatomic) id delegate;
@end
