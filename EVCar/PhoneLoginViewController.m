//
//  PhoneLoginViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneLoginViewController.h"
@interface PhoneLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation PhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidAppear:(BOOL)animated{
    [_phoneNumber becomeFirstResponder];
}
-(void)setInit{
    [super setInit];
    [self setLoginUITextField:_phoneNumber];
    [self setLoginUITextField:_password];
    _phoneNumber.delegate =self;
    _password.delegate = self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)backToViewController:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)loginRequest:(id)sender {
    //[self.waitingAnimation startAnimation];
    //[self.waitingAnimation stopAnimation];
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"tabBarController"] animated:YES];
}
- (IBAction)forgetPassword:(id)sender {
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.alpha = 1;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.alpha = 0.55;
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}
@end
