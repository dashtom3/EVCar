//
//  DateAnalyse.m
//  EVCar
//
//  Created by 田程元 on 16/1/18.
//  Copyright (c) 2016年 TIAN. All rights reserved.
//

#import "DateAnalyse.h"

@implementation DateAnalyse

-(NSString *) dateTostr:(NSDate *)date{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    NSString *strDate = [df stringFromDate:date];
    return strDate;
}
-(NSDate *) strToDate:(NSString *)str{
    NSString *subString = [str substringToIndex:10];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy/MM/dd"];
    return [df dateFromString:subString];
}
@end
