//
//  PhoneRegisterViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneRegisterViewController.h"
#import "PhoneVerificationViewController.h"
#import "UserTextField.h"
@interface PhoneRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation PhoneRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self setInit];父类中已经实现了
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [_phoneNumber becomeFirstResponder];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)setInit{
    [super setInit];
    [UserTextField setSingletypeDelegate:_phoneNumber];
    [UserTextField setSingletypeDelegate:_password];
}
- (IBAction)backToViewController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)goToVerificationController:(id)sender {
    //发送手机验证
    [self.waitingAnimation startAnimation];
    [self.waitingAnimation stopAnimation];
    PhoneVerificationViewController *pvvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"phoneVerification"];
    [self.navigationController pushViewController:pvvc animated:YES];
}

- (IBAction)goToServiceContent:(id)sender {
    
}

@end
