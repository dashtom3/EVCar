//
//  WebViewController.h
//  EVCar
//
//  Created by 田程元 on 15/12/15.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic) NSString *webTitle;
@end
