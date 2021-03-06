//
//  httpRequest.m
//  EVCar
//
//  Created by 田程元 on 15/10/24.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import "httpRequest.h"
#import "AFNetworking.h"
@implementation httpRequest

-(void)POST:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager POST:@"http://example.com/resources.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
-(void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}
//发送手机验证码请求 phonenum=138XXXX2345 & SMSType = 00:注册 01:找回密码
-(void)userPhoneRequest:(NSString *)URLString
parameters:(id)parameters
   success:(void (^)(id responseObject))success
            failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/User/GetVerifyCode" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//注册用户 MobileNumber =138XXXX2345 & Password =123456 &verifycode=123456 & username=xxx & idno=xxxxx
-(void)userRegister:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void(^)(NSError *error))failure{
    [self POST:@"http://61.190.61.78/EVCharger/api/User/RegisterUser" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
-(void)userRegister:(NSString *)URLString
            WithFile:(UIImage *)image
            WithParameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    
    [manager POST:@"http://61.190.61.78/EVCharger/api/User/RegisterUser" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFormData:[NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil] name:@"data"];
        [formData appendPartWithFileData :imageData name:@"file" fileName:@"1.png" mimeType:@"image/jpeg"];
        
    } success:^(AFHTTPRequestOperation *operation,id responseObject) {
        
        NSLog(@"Success: %@", responseObject);
        success(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation,NSError *error) {
        
        NSLog(@"Error: %@", error);
        failure(error);
        
    }];
}

//用户登录 phonenum=138XXXX2345&password=123456
//成功：{“code”：“00”，“message”：“success”，“UserId”：“123445”，“token”：“xxx123456”，“certification”：“01”， “username”：“张三”，“phonenum”:”139xxxx0090”}
-(void)userLogin:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/User/Login" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//忘记密码 Phonenum=138XXXX2345 & newpassword=ydjdk7665 & verifycode=123456
-(void)userForgetPass:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(id responseObject))success
         failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/User/FindPassWord" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//修改密码 Phonenum=138XXXX2345& oldpassword=123456&newpassword=yxd654321&token=xx123456
-(void)userChangePass:(NSString *)URLString
           parameters:(id)parameters
              success:(void (^)(id responseObject))success
              failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/User/ChangePassWord" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//用户登出 Phonenum=138XXXX2345 & token=123456
-(void)userLogout:(NSString *)URLString
           parameters:(id)parameters
              success:(void (^)(id responseObject))success
              failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/User/Logout" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//获取所有充电桩点信息
-(void)getAllChargerPark:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id responseObject))success
             failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/Charger/GetAllRegion" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//获取所有充电桩信息
-(void)getAllChargerParkInfo:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/Charger/GetAllTerminalInfo" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//获取所有汽车点信息
-(void)getAllCarParkInfo:(NSString *)URLString
                  parameters:(id)parameters
                     success:(void (^)(id responseObject))success
                     failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/Car/GetAllCarRegion" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//获取车点汽车信息
-(void)getAlllCarInParkInfo:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/Car/GetCarsByRegion" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//生成订单
-(void)generateOrder:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id responseObject))success
             failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/EVOrders/GenerateOrder" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
//获取用户所有订单
-(void)getAllOrders:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id responseObject))success
             failure:(void(^)(NSError *error))failure{
    [self GET:@"http://61.190.61.78/EVCharger/api/EVOrders/GetOrdersByUserId" parameters:parameters success:^(id responseObject){
        NSLog(@"JSON: %@", responseObject);
        success(responseObject);
    }failure:^(NSError *error){
        NSLog(@"Error: %@", error);
        failure(error);
    }];
}
@end
