//
//  PhoneUserInfoViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneUserInfoViewController.h"


@interface PhoneUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textRealName;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textDriverLisence;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadDirverPic;
@property (strong, nonatomic) IBOutlet UILabel *labelDetail;


@end

@implementation PhoneUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setInit{
    [super setInit];
    _btnLoadDirverPic.layer.cornerRadius = 6.0f;
    [self setRegisterUITextField:_textRealName];
    [self setRegisterUITextField:_textEmail];
    [self setRegisterUITextField:_textDriverLisence];
    _textRealName.delegate = self;
    _textEmail.delegate = self;
    _textDriverLisence.delegate = self;
    _labelDetail.attributedText = [self stringChange:@"请按照提示完善您的个人信息" Color:[UIColor redColor] Range:NSMakeRange(9, 4)];
}
- (IBAction)completeUserInfo:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"注册成功" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backToPhoneVerification:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor1].CGColor;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor2].CGColor;
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
