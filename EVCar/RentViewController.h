//
//  RentViewController.h
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "BaseViewController.h"
#import "RentView.h"
@interface RentViewController : BaseViewController<carAlertViewDelegate,UIScrollViewDelegate>
@property (nonatomic) NSMutableDictionary *data;
@end
