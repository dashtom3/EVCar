//
//  WebViewController.m
//  EVCar
//
//  Created by 田程元 on 15/12/15.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController (){
    NSArray *data;
}
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //@"会员注册",@"新手上路",@"计费规则",@"充电须知",@"保障服务",@"常见问题"
    data = [NSArray arrayWithObjects:@{@"url":@"http://61.190.61.78/EVCharger/help/evcharger/service.html",@"title":@"服务条款"},
            @{@"url":@"http://58.32.252.60:8080/isv2/help/orderVehicle.html",@"title":@"预订车辆"},@{@"url":@"http://58.32.252.60:8080/isv2/help/orderPay.html",@"title":@"订单支付"},@{@"url":@"http://58.32.252.60:8080/isv2/help/register.html",@"title":@"会员注册"},@{@"url":@"http://58.32.252.60:8080/isv2/help/newUser.htm",@"title":@"新手上路"},@{@"url":@"http://58.32.252.60:8080/isv2/help/priceRule.html",@"title":@"计费规则"},@{@"url":@"http://58.32.252.60:8080/isv2/help/chargeDes.html",@"title":@"充电须知"},@{@"url":@"http://58.32.252.60:8080/isv2/help/guarantee.html",@"title":@"保障服务"},@{@"url":@"http://58.32.252.60:8080/isv2/help/question.html",@"title":@"常见问题"}, nil];
}
-(void)viewWillAppear:(BOOL)animated{
    for(int i=0;i<data.count;i++){
        if([[data[i] valueForKey:@"title"]isEqualToString:_webTitle]){
            _labelTitle.text = [data[i] valueForKey:@"title"];
            [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[data[i] valueForKey:@"url"]]]];
        }
    }
    [self setNavBar];
}
-(void)setNavBar{
    [self.navigationController setNavigationBarHidden:true];
    //[self hideTabBar];
}
-(void)setInit{
    [super setInit];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backToRegisterView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
