//
//  PhoneUserInfoViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneUserInfoViewController.h"
#import "httpRequest.h"

@interface PhoneUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textRealName;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textDriverLisence;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadDirverPic;
@property (strong, nonatomic) IBOutlet UILabel *labelDetail;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstant;


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
- (void)viewDidAppear:(BOOL)animated{
    [_textRealName becomeFirstResponder];
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
    if(_textRealName.text.length == 0){
        [self showAlertView:@"请填写姓名信息"];
        [_textRealName becomeFirstResponder];
    }else if(_textEmail.text.length == 0){
        [self showAlertView:@"请填写身份证号"];
        [_textEmail becomeFirstResponder];
    }else{
        [_textEmail resignFirstResponder];
        [_textRealName resignFirstResponder];
        [_textDriverLisence resignFirstResponder];
        self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
        [self.view addSubview:self.waitingAnimation];
        [self.waitingAnimation startAnimation];
        httpRequest *hr = [[httpRequest alloc]init];
        [hr userRegister:nil parameters:@{@"phonenum":[[NSUserDefaults.standardUserDefaults valueForKey:@"register"] valueForKey:@"username"],@"Password":[[NSUserDefaults.standardUserDefaults valueForKey:@"register"] valueForKey:@"password"],@"verifycode":[[NSUserDefaults.standardUserDefaults valueForKey:@"register"] valueForKey:@"verification"],@"username":[[NSUserDefaults.standardUserDefaults valueForKey:@"register"] valueForKey:@"username"],@"idno":_textEmail.text} success:^(id responseObject) {
        [self.waitingAnimation stopAnimation];
        if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
            [self showAlertView:@"注册成功"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self showAlertView:@"注册失败，目前正在测试"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        [self.waitingAnimation stopAnimation];
        [self showAlertView:@"网络连接失败,测试阶段暂时让你到下一个页面~.~"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    }
}
- (IBAction)backToPhoneVerification:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor1].CGColor;
    if(textField.tag == 2){
        self.topConstant.constant = 6;
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor2].CGColor;
    if(textField.tag == 2){
        self.topConstant.constant = 96;
    }
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag == 0){
        [_textEmail becomeFirstResponder];
    }else if(textField.tag == 1){
        [_textDriverLisence becomeFirstResponder];
    }else{
        self.topConstant.constant = 96;
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
