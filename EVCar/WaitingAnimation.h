//
//  WaitingAnimation.h
//  EVCar
//
//  Created by 田程元 on 15/10/22.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaitingAnimation : UIView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitingActivity;
@property (weak, nonatomic) IBOutlet UILabel *waitingLabel;
-(id)initWithNum:(int)Num WithMainFrame:(CGRect)frame;
-(void)startAnimation;
-(void)stopAnimation;
@end
