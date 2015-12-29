//
//  PhoneUserInfoViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "PhoneUserInfoViewController.h"
#import "httpRequest.h"

@interface PhoneUserInfoViewController (){
    UIImage *image;
}
@property (weak, nonatomic) IBOutlet UITextField *textRealName;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textDriverLisence;
@property (weak, nonatomic) IBOutlet UIButton *btnLoadDirverPic;
@property (strong, nonatomic) IBOutlet UILabel *labelDetail;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *topConstant;
@property (strong, nonatomic) UIActionSheet *actionSheet;

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
    }else if(image){
        [_textEmail resignFirstResponder];
        [_textRealName resignFirstResponder];
        [_textDriverLisence resignFirstResponder];
        self.waitingAnimation = [[WaitingAnimation alloc]initWithNum:0 WithMainFrame:self.view.frame];
        [self.view addSubview:self.waitingAnimation];
        [self.waitingAnimation startAnimation];
        httpRequest *hr = [[httpRequest alloc]init];
        [hr userRegister:nil WithFile:image WithParameters:@{@"phonenum":[[NSUserDefaults.standardUserDefaults valueForKey:@"register"] valueForKey:@"username"] ,@"Password":[[NSUserDefaults.standardUserDefaults valueForKey:@"register"] valueForKey:@"password"],@"verifycode":[[NSUserDefaults.standardUserDefaults valueForKey:@"register"] valueForKey:@"verification"],@"MemberName":_textRealName.text,@"IdCard":_textEmail.text,@"Nation":@"汉族",@"Address":@"上海市",@"marital":@"未婚",@"Sex":@"女",@"Birthday":@"1991-05-04"} success:^(id responseObject) {
            [self.waitingAnimation stopAnimation];
            if([[responseObject valueForKey:@"code"] isEqualToString:@"00"]){
                [self showAlertView:@"注册成功"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self showAlertView:@"注册失败"];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            //[self.waitingAnimation stopAnimation];
            [self showAlertView:@"网络连接失败"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }else{
        [self showAlertView:@"请上传照片"];
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
- (IBAction)uploadUserPic:(id)sender {
    [self callActionSheetFunc];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}

- (void)callActionSheetFunc{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }else{
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    
    self.actionSheet.tag = 1000;
    [self.actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 1000) {
        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    //来源:相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    //来源:相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                case 2:
                    return;
            }
        }
        else {
            if (buttonIndex == 2) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
    }
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
