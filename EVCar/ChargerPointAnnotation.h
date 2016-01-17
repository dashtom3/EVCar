//
//  ChargerPointAnnotation.h
//  EVCar
//
//  Created by 田程元 on 16/1/17.
//  Copyright (c) 2016年 TIAN. All rights reserved.
//


#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface ChargerPointAnnotation : BMKPointAnnotation
@property (nonatomic) NSMutableDictionary *data;
@end
