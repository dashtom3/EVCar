//
//  PileViewController.m
//  EVCar
//
//  Created by 田程元 on 15/11/23.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PileViewController.h"
#import "PileView.h"
@interface PileViewController ()

@end

@implementation PileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}
-(void)setInit{
    [super setInit];

    //_data = [NSArray arrayWithObjects:@{},@{},@{},nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self setRentNavBar];
    PileView *pileView = [[[NSBundle mainBundle] loadNibNamed:@"PileView" owner:nil options:nil] firstObject];
    pileView.frame = CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-60);
    pileView.delegate = self;
    [self.view addSubview:pileView];
}

-(void)setRentNavBar{
    [self.navigationController setNavigationBarHidden:false];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"base_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMainView)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.title = @"安徽国际商务中心";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor BackgroundBlueColor]];
    [self setNavgationControllerLine];
    [self hideTabBar];
}
-(void)showAlertView:(NSArray *)data{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"预约成功" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)backToMainView{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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