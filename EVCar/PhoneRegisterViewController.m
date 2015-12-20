//
//  PhoneRegisterViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneRegisterViewController.h"
#import "PhoneVerificationViewController.h"
#import "WebViewController.h"
#import "httpRequest.h"
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
    [self setRegisterUITextField:_phoneNumber];
    [self setRegisterUITextField:_password];
    _phoneNumber.delegate = self;
    _password.delegate = self;
}
- (IBAction)backToViewController:(id)sender {
    [_phoneNumber resignFirstResponder];
    [_password resignFirstResponder];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)goToVerificationController:(id)sender {
//    httpRequest *hr = [[httpRequest alloc]init];
//    [hr userRegister:nil parameters:@{@"phonenum":@"15921161091",@"password":@"123456",@"verifycode":@"6305",@"username":@"郑璞睿",@"idno":@"371202199105040834"} success:^(id responseObject) {
//        [self.waitingAnimation stopAnimation];
//        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
//            [self showAlertView:@"注册成功"];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }else{
//            [self showAlertView:@"注册失败"];
//            [self dismissViewControllerAnimated:YES completion:nil];
//        }
//    } failure:^(NSError *error) {
//        [self.waitingAnimation stopAnimation];
//        [self showAlertView:@"网络连接失败"];
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];

    //发送手机验证
    if(_phoneNumber.text.length != 11){
        [self showAlertView:@"请输入11位手机号"];
        [_phoneNumber becomeFirstResponder];
    }else if(_password.text.length == 0){
        [self showAlertView:@"请输入密码"];
        [_password becomeFirstResponder];
    }else{
        [_password resignFirstResponder];
        [_phoneNumber resignFirstResponder];
        [[NSUserDefaults standardUserDefaults] setObject:@{@"username":_phoneNumber.text,@"password":_password.text} forKey:@"register"];
        self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
        [self.view addSubview:self.waitingAnimation];
        [self.waitingAnimation startAnimation];
        httpRequest *hr = [[httpRequest alloc]init];
        [hr userPhoneRequest:nil parameters:@{@"phonenum":_phoneNumber.text,@"SMSType":@"00"} success:^(id responseObject) {
            [self.waitingAnimation stopAnimation];
            if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
                [self showAlertView:@"验证码已发送至手机"];
                PhoneVerificationViewController *pvvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"phoneVerification"];
                [self.navigationController pushViewController:pvvc animated:YES];
            }else{
                [self showAlertView:@"手机验证码发送失败，请在本页点击重新发送"];
                PhoneVerificationViewController *pvvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"phoneVerification"];
                [self.navigationController pushViewController:pvvc animated:YES];
            }
        } failure:^(NSError *error) {
            [self.waitingAnimation stopAnimation];
            [self showAlertView:@"网络连接失败"];
            PhoneVerificationViewController *pvvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"phoneVerification"];
            [self.navigationController pushViewController:pvvc animated:YES];
        }];
    }
}
//服务条款
- (IBAction)goToServiceContent:(id)sender {
    WebViewController *wvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"webView"];
    wvc.webTitle = @"服务条款";
    [self.navigationController pushViewController:wvc animated:YES];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor1].CGColor;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor2].CGColor;
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag==0){
        [_password becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return true;
}
@end
