//
//  PhoneVerificationViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneVerificationViewController.h"
#import "PhoneUserInfoViewController.h"
@interface PhoneVerificationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnResend;

@end

@implementation PhoneVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setInit{
    [super setInit];
    _btnResend.layer.cornerRadius = 6.0f;
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
- (IBAction)backToPhoneRegisterViewController:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)goToPhoneUserInfoViewController:(id)sender {
    PhoneUserInfoViewController *puivc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"phoneUserInfo"];
    [self.navigationController pushViewController:puivc animated:YES];
}
- (IBAction)resendVerification:(id)sender {
    [self.waitingAnimation startAnimation];
    [self.waitingAnimation stopAnimation];
}

@end
