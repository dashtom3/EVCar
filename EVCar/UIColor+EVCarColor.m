//
//  UIColor+EVCarColor.m
//  EVCar
//
//  Created by 田程元 on 15/10/22.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "UIColor+EVCarColor.h"

@implementation UIColor (EVCarColor)

+(UIColor *)borderColor1{
    return [UIColor colorWithRed:87.0/255.0 green:123.0/255.0 blue:243.0/255.0 alpha:0.55];
}
+(UIColor *)borderColor2{
    return [UIColor lightGrayColor];
}
+(UIColor *)MainColor{
    return [UIColor colorWithRed:128.0/255.0 green:214.0/255.0 blue:60.0/255.0 alpha:1.0];
}
+(UIColor *)BackgroundBlueColor{
    return [UIColor colorWithRed:24.0/255.0 green:149.0/255.0 blue:255.0/255.0 alpha:1.0];
}
@end
