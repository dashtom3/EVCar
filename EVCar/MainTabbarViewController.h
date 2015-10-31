//
//  MainTabbarViewController.h
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabbarViewController : UITabBarController
-(void)setBarItemWithViewController:(UIViewController *)vc WithName:(NSString *)name WithImage:(NSString *)image WithImageSelected:(NSString *)imageSelected;
@end
