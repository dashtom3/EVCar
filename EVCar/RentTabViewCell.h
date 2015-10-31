//
//  RentTabViewCell.h
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentTabViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageMap;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UILabel *labelDetail;
@property (strong, nonatomic) IBOutlet UILabel *labelRentState;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constantTitle;
-(void)setValueWithImage:(NSString *)imageName WithTitle:(NSString *)title WithDetail:(NSString *)detail;
-(void)setRentState:(NSString *)state;
@end
