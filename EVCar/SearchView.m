//
//  SearchView.m
//  EVCar
//
//  Created by 田程元 on 15/10/29.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setDataWithImage:(NSString*)image WithType:(NSString*)type WithContent:(NSString*)content{
    _imageView.image = [UIImage imageNamed:image];
    _labelContent.text = content;
    _labelType.text = type;
}
-(void)setContent:(NSString*)content{
    _labelContent.text = content;
}
@end
