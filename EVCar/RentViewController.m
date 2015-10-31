//
//  RentViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentViewController.h"
#import "RentView.h"
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
    
    
    _data = [NSArray arrayWithObjects:@{},@{},@{},nil];
}
-(void)viewWillAppear:(BOOL)animated{
    [self setRentNavBar];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_data.count, 0);
    _scrollView.alwaysBounceVertical = NO;
    _scrollView.delegate = self;
    for(int i=0;i<_data.count;i++){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        view.backgroundColor = [UIColor blackColor];
                RentView *rentView = [[[NSBundle mainBundle] loadNibNamed:@"RentView" owner:nil options:nil] firstObject];
                NSLog(@"%f %f",SCREEN_WIDTH,SCREEN_HEIGHT);
                rentView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60);
                rentView.delegate = self;
        [view addSubview:rentView];
        [_scrollView addSubview:view];
    }
}
-(void)setNavgationControllerLine{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationController.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}
-(void)setRentNavBar{
    [self.navigationController setNavigationBarHidden:false];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"base_back_white"] style:UIBarButtonItemStylePlain target:self action:@selector(backToMainView)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.title = @"安徽国际商务中心";
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor MainColor]];
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
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x);
    _pageControl.currentPage = (int)floor(scrollView.contentOffset.x-SCREEN_WIDTH)+1;
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
