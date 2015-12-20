//
//  PhoneForgetViewController.m
//  EVCar
//
//  Created by 田程元 on 15/12/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneForgetViewController.h"
#import "httpRequest.h"
@interface PhoneForgetViewController ()
@property (strong, nonatomic) IBOutlet UITextField *textPhoneNumber;
@property (strong, nonatomic) IBOutlet UITextField *textPhonePass;
@property (strong, nonatomic) IBOutlet UITextField *textPhoneVeriCode;
@property (strong, nonatomic) IBOutlet UIButton *btnVerifyCodeResend;

@end

@implementation PhoneForgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    [_textPhoneNumber becomeFirstResponder];
}
-(void)setInit{
    [super setInit];
    [self setRegisterUITextField:_textPhoneNumber];
    [self setRegisterUITextField:_textPhonePass];
    [self setRegisterUITextField:_textPhoneVeriCode];
    _textPhoneNumber.delegate = self;
    _textPhonePass.delegate = self;
    _textPhoneVeriCode.delegate = self;
    _btnVerifyCodeResend.layer.cornerRadius = 6.0f;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sendForgetPass:(id)sender {
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    [hr userForgetPass:nil parameters:@{@"phonenum":_textPhoneNumber.text,@"newpassword":_textPhonePass.text,@"verifycode":_textPhoneVeriCode.text} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            [self showAlertView:@"新密码修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showAlertView:@"修改密码失败"];
        }

    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"网络连接失败"];
    }];
}
- (IBAction)resendVeriCode:(id)sender {
    self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
    [self.view addSubview:self.waitingAnimation];
    [self.waitingAnimation startAnimation];
    httpRequest *hr = [[httpRequest alloc]init];
    [hr userPhoneRequest:nil parameters:@{@"phonenum":_textPhoneNumber.text,@"SMSType":@"00"} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            [self showAlertView:@"验证码已发送至手机"];
        }else{
            [self showAlertView:@"手机验证码发送失败，请在本页点击重新发送"];
        }
    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"网络连接失败"];
    }];
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
        [_textPhonePass becomeFirstResponder];
    }else if(textField.tag == 1){
        [_textPhoneVeriCode becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return true;
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
