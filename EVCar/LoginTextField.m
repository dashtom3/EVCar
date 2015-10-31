//
//  LoginTextField.m
//  EVCar
//
//  Created by 田程元 on 15/10/27.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)setSingletypeDelegate:(UITextField *)uiTextField {
    
    static LoginTextField *loginTextField;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginTextField = [[LoginTextField alloc] init];
    });
    uiTextField.delegate = loginTextField;
    uiTextField.layer.cornerRadius = 6.0f;
    uiTextField.layer.borderWidth = 0.6;
    [uiTextField.layer setBorderColor:[UIColor borderColor2].CGColor];
    uiTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    uiTextField.leftViewMode = UITextFieldViewModeAlways;
    uiTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    uiTextField.alpha = 0.55;
    return loginTextField;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.alpha = 1;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.alpha = 0.55;
}

@end
