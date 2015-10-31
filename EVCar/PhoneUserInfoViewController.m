//
//  PhoneUserInfoViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneUserInfoViewController.h"
#import "UserTextField.h"

@interface PhoneUserInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textRealName;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textDriverLisence;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadDirverPic;


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
    [UserTextField setSingletypeDelegate:_textRealName];
    [UserTextField setSingletypeDelegate:_textEmail];
    [UserTextField setSingletypeDelegate:_textDriverLisence];
}
- (IBAction)completeUserInfo:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backToPhoneVerification:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
