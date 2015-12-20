//
//  PileViewController.h
//  EVCar
//
//  Created by 田程元 on 15/11/23.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "BaseViewController.h"
#import "PileView.h"
@interface PileViewController : BaseViewController<pileAlertViewDelegate>
@property (nonatomic) NSMutableDictionary *data;


@end
