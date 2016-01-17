//
//  DateAnalyse.h
//  EVCar
//
//  Created by 田程元 on 16/1/18.
//  Copyright (c) 2016年 TIAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateAnalyse : NSObject

-(NSString *) dateTostr:(NSDate *)date;
-(NSDate *) strToDate:(NSString *)str;
@end
