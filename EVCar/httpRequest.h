//
//  httpRequest.h
//  EVCar
//
//  Created by 田程元 on 15/10/24.
//  Copyright (c) 2015年 TIAN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface httpRequest : NSObject
//发送手机验证码请求 mobileNumber=138XXXX2345 & SMSType = 00:注册 01:找回密码
-(void)userPhoneRequest:(NSString *)URLString
             parameters:(id)parameters
                success:(void (^)(id responseObject))success
                failure:(void(^)(NSError *error))failure;
//注册用户 MobileNumber =138XXXX2345 & Password =123456 &verifycode=123456 & username=xxx & idno=xxxxx
-(void)userRegister:(NSString *)URLString
         parameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void(^)(NSError *error))failure;
-(void)userRegister:(NSString *)URLString
           WithFile:(UIImage *)image
     WithParameters:(id)parameters
            success:(void (^)(id responseObject))success
            failure:(void(^)(NSError *error))failure;
//用户登录 phonenum=138XXXX2345&password=123456
//成功：{“code”：“00”，“message”：“success”，“UserId”：“123445”，“token”：“xxx123456”，“certification”：“01”， “username”：“张三”，“phonenum”:”139xxxx0090”}
-(void)userLogin:(NSString *)URLString
      parameters:(id)parameters
         success:(void (^)(id responseObject))success
         failure:(void(^)(NSError *error))failure;
//忘记密码 Phonenum=138XXXX2345 & newpassword=ydjdk7665 & verifycode=123456
-(void)userForgetPass:(NSString *)URLString
           parameters:(id)parameters
              success:(void (^)(id responseObject))success
              failure:(void(^)(NSError *error))failure;
//修改密码 Phonenum=138XXXX2345& oldpassword=123456&newpassword=yxd654321&token=xx123456
-(void)userChangePass:(NSString *)URLString
           parameters:(id)parameters
              success:(void (^)(id responseObject))success
              failure:(void(^)(NSError *error))failure;
//用户登出 Phonenum=138XXXX2345 & token=123456
-(void)userLogout:(NSString *)URLString
       parameters:(id)parameters
          success:(void (^)(id responseObject))success
          failure:(void(^)(NSError *error))failure;
-(void)getAllCarPark:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id responseObject))success
             failure:(void(^)(NSError *error))failure;
//获取所有充电桩点信息
-(void)getAllChargerPark:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))success
                 failure:(void(^)(NSError *error))failure;
//获取所有充电桩信息
-(void)getAllChargerParkInfo:(NSString *)URLString
                  parameters:(id)parameters
                     success:(void (^)(id responseObject))success
                     failure:(void(^)(NSError *error))failure;
@end
