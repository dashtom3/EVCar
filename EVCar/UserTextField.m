//
//  UserTextField.m
//  EVCar
//
//  Created by 田程元 on 15/10/27.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "UserTextField.h"

@implementation UserTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)setSingletypeDelegate:(UITextField *)uiTextField {
    
    static UserTextField *userTextField;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userTextField = [[UserTextField alloc] init];
    });
    uiTextField.delegate = userTextField;
    uiTextField.layer.cornerRadius = 6.0f;
    uiTextField.layer.borderWidth = 0.6;
    [uiTextField.layer setBorderColor:[UIColor borderColor2].CGColor];
    uiTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 0)];
    uiTextField.leftViewMode = UITextFieldViewModeAlways;
    uiTextField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    return userTextField;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor1].CGColor;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    textField.layer.borderColor = [UIColor borderColor2].CGColor;
}
@end
