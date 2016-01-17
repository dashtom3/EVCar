//
//  PileView.h
//  EVCar
//
//  Created by 田程元 on 15/11/23.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//
@protocol  pileAlertViewDelegate

-(void)showOrderView:(NSArray *)data;

@end
#import <UIKit/UIKit.h>

@interface PileView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *data;
@property (nonatomic) NSArray *mapdata;
@property (strong, nonatomic) IBOutlet UIButton *btnPile;

@property (nonatomic) id delegate;
-(void)setData:(NSMutableDictionary *)value;
@end
