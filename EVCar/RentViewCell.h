//
//  RentViewCell.h
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RentViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *labelDetail;
@property (strong, nonatomic) IBOutlet UILabel *labelTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imageName;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *constant;
@property (strong, nonatomic) IBOutlet UIImageView *imageDrop;

-(void)setImage:(NSString *)image Title:(NSString *)title Detail:(NSString *)detail Type:(int)type;
@end
