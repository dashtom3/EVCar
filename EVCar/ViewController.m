//
//  ViewController.m
//  EVCar
//
//  Created by 田程元 on 15/10/20.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "ViewController.h"
#import "PhoneLoginViewController.h"
#import "PhoneRegisterViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setInit{
    [self.navigationController setNavigationBarHidden:true];
}
- (IBAction)registerUser:(id)sender {

    PhoneRegisterViewController *phvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"phoneRegister"];
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:phvc] animated:true completion:nil];
    
}
- (IBAction)loginUser:(id)sender {
    PhoneLoginViewController *plvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"phoneLogin"];
    [self presentViewController: [[UINavigationController alloc]initWithRootViewController:plvc] animated:true completion:nil];
}
@end
