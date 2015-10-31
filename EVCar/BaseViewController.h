//
//  BaseViewController.h
//  EVCar
//
//  Created by 田程元 on 15/10/24.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WaitingAnimation.h"
@interface BaseViewController : UIViewController

@property (nonatomic) WaitingAnimation *waitingAnimation;

-(void)setInit;
-(NSMutableAttributedString *)stringChange:(NSString *)text Color:(UIColor *)color Range:(NSRange )range;
- (void)showTabBar;
- (void)hideTabBar;
-(void)setMainNavBar;
-(void)setRegisterUITextField:(UITextField *)uiTextField;
-(void)setLoginUITextField:(UITextField *)uiTextField;
@end
