//
//  RentViewCell.m
//  EVCar
//
//  Created by 田程元 on 15/10/30.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentViewCell.h"

@implementation RentViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//1 有下拉 0 没有下拉
-(void)setImage:(NSString *)image Title:(NSString *)title Detail:(NSString *)detail Type:(int)type{
    _imageName.image = [UIImage imageNamed:image];
    _labelTitle.text = title;
    _labelDetail.text = detail;
    if(type == 0){
        _imageDrop.alpha = 0;
        _constant.constant = 12;
        _labelDetail.textColor = [UIColor lightGrayColor];
    }else{
        _imageDrop.alpha = 1;
        _constant.constant = 26;
        _labelDetail.textColor = [UIColor borderColor1];
    }
}
@end
