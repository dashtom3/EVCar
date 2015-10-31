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
@property (strong, nonatomic) IBOutlet UITextField *labelVerification;
@property (strong, nonatomic) IBOutlet UILabel *labelDetail;

@end

@implementation PhoneVerificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setInit{
    [super setInit];
    _btnResend.layer.cornerRadius = 6.0f;
    [self setRegisterUITextField:_labelVerification];
    _labelVerification.delegate = self;
    _labelDetail.attributedText = [self stringChange:@"请输入四位发送至您号码的验证数字" Color:[UIColor redColor] Range:NSMakeRange(3,2)];
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
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor1].CGColor;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor2].CGColor;
    [textField resignFirstResponder];
}
@end
