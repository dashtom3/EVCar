//
//  RentViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentViewController.h"
#import "RentView.h"
#import "DateAnalyse.h"
#import "httpRequest.h"
@interface RentViewController ()
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation RentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)setInit{
    [super setInit];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self setRentNavBar];
    _pageControl.numberOfPages = ((NSArray *)[_data valueForKey:@"data"]).count;
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*((NSArray *)[_data valueForKey:@"data"]).count, 0);
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.delegate = self;
    for(int i=0;i<((NSArray *)[_data valueForKey:@"data"]).count;i++){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        view.backgroundColor = [UIColor blackColor];
                RentView *rentView = [[[NSBundle mainBundle] loadNibNamed:@"RentView" owner:nil options:nil] firstObject];
                rentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60);
                rentView.delegate = self;
        [rentView setData:((NSArray *)[_data valueForKey:@"data"])[i]];
        [view addSubview:rentView];
        [_scrollView addSubview:view];
    }
}

-(void)setRentNavBar{
    [self.navigationController setNavigationBarHidden:false];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"base_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMainView)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.title = [[_data valueForKey:@"title"] valueForKey:@"locationName"];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor MainColor]];
    [self setNavgationControllerLine];
    [self hideTabBar];
}
-(void)orderCarView:(NSDictionary *)data{
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    DateAnalyse *da= [[DateAnalyse alloc]init];
    NSString *str = [da dateTostr:[NSDate date]];
    [hr generateOrder:nil parameters:@{@"userId":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"UserId"],@"token":[[[NSUserDefaults standardUserDefaults] valueForKey:@"user"] valueForKey:@"token"],@"terminalId":[data valueForKey:@"Car_ID"],@"measPointId":@"0",@"reserveStartTime":str,@"usageTime":@"8.0",@"orderType":@"1"} success:^(id responseObject) {
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    _pageControl.currentPage = (int)floor(scrollView.contentOffset.x/SCREEN_WIDTH);
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
