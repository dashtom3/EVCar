//
//  MainTabbarViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "MainTabbarViewController.h"
#import "RentTabViewController.h"
#import "OrderTabViewController.h"
#import "MessageTabViewController.h"
#import "UserTabViewController.h"
@interface MainTabbarViewController ()

@end

@implementation MainTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInit];
    // Do any additional setup after loading the view.
}
-(void)setInit{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RentTabViewController *rtvc = [sb instantiateViewControllerWithIdentifier:@"rentTab"];
    UINavigationController *nv1 = [[UINavigationController alloc]initWithRootViewController:rtvc];
    OrderTabViewController *otvc = [sb instantiateViewControllerWithIdentifier:@"orderTab"];
    UINavigationController *nv2 = [[UINavigationController alloc]initWithRootViewController:otvc];
    MessageTabViewController *mtvc = [sb instantiateViewControllerWithIdentifier:@"messageTab"];
    UINavigationController *nv3 = [[UINavigationController alloc]initWithRootViewController:mtvc];
    UserTabViewController *utvc = [sb instantiateViewControllerWithIdentifier:@"userTab"];
    UINavigationController *nv4 = [[UINavigationController alloc]initWithRootViewController:utvc];
    
    self.viewControllers = @[nv2,nv1,nv4];
    self.selectedIndex = 1;
    [self setBarItemWithViewController:rtvc WithName:@"预约" WithImage:@"main_rent" WithImageSelected:@"main_rent2"];
    [self setBarItemWithViewController:otvc WithName:@"订单" WithImage:@"main_order" WithImageSelected:@"main_order2"];
    [self setBarItemWithViewController:mtvc WithName:@"消息" WithImage:@"main_message" WithImageSelected:@"main_message2"];
    [self setBarItemWithViewController:utvc WithName:@"个人" WithImage:@"main_user" WithImageSelected:@"main_user2"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setBarItemWithViewController:(UIViewController *)vc WithName:(NSString *)name WithImage:(NSString *)image WithImageSelected:(NSString *)imageSelected{
    vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:name image:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor MainColor]} forState:UIControlStateSelected];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
