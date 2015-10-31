//
//  RentTabViewCell.m
//  EVCar
//
//  Created by 田程元 on 15/10/28.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "RentTabViewCell.h"

@implementation RentTabViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setValueWithImage:(NSString *)imageName WithTitle:(NSString *)title WithDetail:(NSString *)detail{
    _imageMap.image = [UIImage imageNamed:imageName];
    _labelTitle.text = title;
    if(detail == nil){
        _labelDetail.text = @"";
        _constantTitle.constant = 0;
    }else{
        _labelDetail.text = detail;
        _constantTitle.constant = 7;
    }
    _labelRentState.text = @"";
}
//0:已完成 1:已取消 2:违章查证中
-(void)setRentState:(NSString *)state{
    switch ([state intValue]) {
        case 0:{
            _labelRentState.text = @"已完成";
            _labelRentState.textColor = [UIColor borderColor1];
            _imageMap.alpha = 1;
            break;
        }
        case 1:{
            _labelRentState.text = @"已取消";
            _labelRentState.textColor = [UIColor lightGrayColor];
            _imageMap.alpha = 0.4;
            break;
        }
        case 2:{
            _labelRentState.text = @"违章查处中";
            _labelRentState.textColor = [UIColor redColor];
            _imageMap.alpha = 1;
            break;
        }
        default:
            break;
    }
}
@end
