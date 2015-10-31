//
//  CarView.m
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "CarView.h"

@implementation CarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    _labelCarName.layer.cornerRadius = 4.0f;
    _labelCarName.layer.masksToBounds = YES;
}
@end
