//
//  OrderDetailViewController.h
//  EVCar
//
//  Created by 田程元 on 15/12/29.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic)    NSArray *data;
-(void)setDataSet:(NSMutableDictionary *)dataSet;
@end
