//
//  PileViewController.m
//  EVCar
//
//  Created by 田程元 on 15/11/23.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PileViewController.h"
#import "PileView.h"
#import "httpRequest.h"
#import "DateAnalyse.h"
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
    self.title = [_data valueForKey:@"TerminalName"];
    PileView *pileView = [[[NSBundle mainBundle] loadNibNamed:@"PileView" owner:nil options:nil] firstObject];
    pileView.frame = CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-60);
    pileView.delegate = self;
    [self.view addSubview:pileView];
    [pileView setData:_data];
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
-(void)showOrderView:(NSArray *)data{
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    DateAnalyse *da= [[DateAnalyse alloc]init];
    [hr generateOrder:nil parameters:@{@"userId":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"UserId"],@"token":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"token"],@"terminalId":[_data valueForKey:@"TerminalId"],@"measPointId":@"0",@"reserveStartTime":[da dateTostr:[NSDate date]],@"usageTime":@"8.0",@"orderType":@"0"} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            [self showAlertView:@"预订成功"];
        }else{
            [self showAlertView:@"设备已经预定"];
        }
        
    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"预定服务网络调用失败"];
    }];
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
