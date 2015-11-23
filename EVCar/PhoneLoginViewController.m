//
//  PhoneLoginViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneLoginViewController.h"
#import "httpRequest.h"
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
    if([[NSUserDefaults standardUserDefaults]valueForKey:@"user"]){
        if([[[NSUserDefaults standardUserDefaults]valueForKey:@"user"] valueForKey:@"phonenum"]){
            _phoneNumber.text = [[[NSUserDefaults standardUserDefaults]valueForKey:@"user"] valueForKey:@"phonenum"];
        }
        if([[[NSUserDefaults standardUserDefaults]valueForKey:@"user"] valueForKey:@"password"]){
            _password.text =[[[NSUserDefaults standardUserDefaults]valueForKey:@"user"] valueForKey:@"password"];
        }
    }
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
    [_phoneNumber resignFirstResponder];
    [_password resignFirstResponder];
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)loginRequest:(id)sender {
    if(_phoneNumber.text.length != 11){
        [self showAlertView:@"请输入11位手机号"];
        [_phoneNumber becomeFirstResponder];
    }else if(_password.text.length == 0){
        [self showAlertView:@"请输入密码"];
        [_password becomeFirstResponder];
    }else{
        [_password resignFirstResponder];
        [_phoneNumber resignFirstResponder];
        self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
        [self.view addSubview:self.waitingAnimation];
        [self.waitingAnimation startAnimation];
        httpRequest *hr = [[httpRequest alloc]init];
        [hr userLogin:nil parameters:@{@"phonenum":_phoneNumber.text,@"password":_password.text} success:^(id responseObject) {
            [self.waitingAnimation stopAnimation];
            if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
                [self showAlertView:@"用户登录成功!"];
                NSMutableDictionary *content = [responseObject mutableCopy];
                [content setObject:_password.text forKey:@"password"];
                [[NSUserDefaults standardUserDefaults]setObject:content forKey:@"user"];
                [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"tabBarController"] animated:YES];
            }else{
                [self showAlertView:@"用户登录失败,测试阶段放你通过！~。~"];
                [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"tabBarController"] animated:YES];
            }
        } failure:^(NSError *error) {
            [self.waitingAnimation stopAnimation];
            [self showAlertView:@"用户登录失败,测试阶段放你通过！~。~"];
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"tabBarController"] animated:YES];
        }];
    }

    
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
    if(textField.tag == 0){
        [_password becomeFirstResponder];
    }
    return true;
}
@end
