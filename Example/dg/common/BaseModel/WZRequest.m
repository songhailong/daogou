//
//  WZRequest.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZRequest.h"
#import <NSDictionary+JSONString.h>
#import "NSString+Hash.h"
#import "WZModule.h"

@implementation WZRequest

static NSString * const clientKey = @"ebf4c30a0d6142859c7dd33652f9ef54";

+ ( NSURLSessionDataTask *)defaultPOST:( NSString *)URLString
                            parameters:( NSDictionary *)parameters
                          headerFields:( id)headerFields
                            completion:( WZResponseObjectBlock)completeBlock{
    yhlSessionManager *manager = [yhlSessionManager sharedManager];
    
    [MBProgressHUD showMessage:@"图片识别中…"];
    
    return [manager POST:URLString parameters:parameters headerFields:headerFields completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        [MBProgressHUD hideHUD];
        WZResponse *response =[WZResponse instanceWithData:json];
        response.error=err;
        completeBlock(response);
    }];
}

+ ( NSURLSessionDataTask *)POST:( NSString *)URLString
                     parameters:( NSDictionary *)parameters
                   headerFields:( id)headerFields
                     completion:( WZResponseObjectBlock)completeBlock{
    
    yhlSessionManager *manager = [yhlSessionManager sharedManager];
    
    [MBProgressHUD showMessage:@"加载中…"];
    
    
    NSMutableDictionary *param = [parameters mutableCopy];
    if (param==nil) {
        param=[NSMutableDictionary new];
    }
    param[@"platform"]=@"IOS";
    
    param[@"clientKey"] = clientKey;
    NSTimeInterval timeinterval = [[NSDate date] timeIntervalSince1970];
    NSString *signString = [self signString:param date:timeinterval];
    param[@"_sign"] = [signString md5String];
    param[@"_date"] =[NSString stringWithFormat:@"%0.f",timeinterval];
    param[@"module"]=@"weizhangchaxun";
    param[@"timestamp"]=[NSString stringWithFormat:@"%0.f",timeinterval];
    
    NSString *ticket = [[NSUserDefaults standardUserDefaults] objectForKey:@"ticket"];
    if(ticket!=nil){
        headerFields = @{@"x-authorization":ticket};
        param[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"ticket"];
    }
    
    return [manager POST:URLString parameters:param headerFields:headerFields completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        [MBProgressHUD hideHUD];
        
        if (err==nil) {
            WZResponse *response =[WZResponse instanceWithData:json];
            
            response.error=err;
            completeBlock(response);
        }else{
            [MBProgressHUD showDelayError:@"系统繁忙、请稍后重试"];
        }
        
    }];
    
}
+ ( NSURLSessionDataTask *)BACKPOST:( NSString *)URLString
                         parameters:( NSDictionary *)parameters
                       headerFields:( id)headerFields
                         completion:( WZResponseObjectBlock)completeBlock{
    
    yhlSessionManager *manager = [yhlSessionManager sharedManager];
    NSMutableDictionary *param = [parameters mutableCopy];
    if (param==nil) {
        param=[NSMutableDictionary new];
    }
    param[@"platform"]=@"IOS";
    param[@"clientKey"] = clientKey;
    NSTimeInterval timeinterval = [[NSDate date] timeIntervalSince1970];
    NSString *signString = [self signString:param date:timeinterval];
    param[@"_sign"] = [signString md5String];
    param[@"_date"] = [NSString stringWithFormat:@"%0.f",timeinterval];
    param[@"module"]=@"weizhangchaxun";
    param[@"timestamp"]=[NSString stringWithFormat:@"%0.f",timeinterval];
    NSString *ticket = [[NSUserDefaults standardUserDefaults] objectForKey:@"ticket"];
    if(ticket!=nil){
        headerFields = @{@"x-authorization":ticket};
        param[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"ticket"];
    }
    return [manager POST:URLString parameters:param headerFields:headerFields completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        WZResponse *response =[WZResponse instanceWithData:json];
        
        response.error=err;
        completeBlock(response);
    }];
    
}

+ ( NSURLSessionDataTask *)GET:( NSString *)URLString
                    parameters:( NSDictionary *)parameters
                  headerFields:( id)headerFields
                    completion:( JSONObjectBlock)completeBlock{
    yhlSessionManager *manager = [yhlSessionManager sharedManager];
    manager.session.configuration.timeoutIntervalForRequest=30;
    NSMutableDictionary *param = [parameters mutableCopy];
    if (param==nil) {
        param=[NSMutableDictionary new];
    }
    param[@"type"]=@"IOS";
    NSString *signString =nil;
    if ([URLString containsString:yhqcouponsearchaction]) {
        signString = [self signStringSearch:param];
        param[@"token"] = [signString md5String];
    }else if ([URLString containsString:yhqcoupongetaction]) {
        signString= [self signString:param];
        param[@"token"] = [signString md5String];
    }
    
    
    
    [MBProgressHUD showMessage:@"加载中…"];
    return [manager GET:URLString parameters:param headerFields:headerFields completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        [MBProgressHUD hideHUD];
        completeBlock(json,err);
    }];
    
}

+ ( NSURLSessionDataTask *)BACKGET:( NSString *)URLString
                        parameters:( NSDictionary *)parameters
                      headerFields:( id)headerFields
                        completion:( JSONObjectBlock)completeBlock{
    NSDictionary *dict =[self appendParam:parameters];
    yhlSessionManager *manager = [yhlSessionManager sharedManager];
    return [manager GET:URLString parameters:dict headerFields:headerFields completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        completeBlock(json,err);
    }];
    
}


+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url parameters:(id)parameters name:(NSString *)name
                                   FromData:(NSArray *)bodyDatas
                             UploadProgress:(NetworkProgress)progress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    
    NSMutableDictionary *param = [parameters mutableCopy];
    if (param==nil) {
        param=[NSMutableDictionary new];
    }
    param[@"platform"]=@"IOS";
    
    
    param[@"clientKey"] = clientKey;
    NSTimeInterval timeinterval = [[NSDate date] timeIntervalSince1970];
    NSString *signString = [self signString:param date:timeinterval];
    param[@"_sign"] = [signString md5String];
    param[@"_date"] = [NSString stringWithFormat:@"%0.f",timeinterval];
    
    param[@"module"]=@"weizhangchaxun";
    param[@"timestamp"]=[NSString stringWithFormat:@"%0.f",timeinterval];
    
    NSMutableDictionary *headerFields = [NSMutableDictionary new];
    NSString *ticket = [[NSUserDefaults standardUserDefaults] objectForKey:@"ticket"];
    if(ticket!=nil){
        headerFields[@"x-authorization"] = ticket;
        param[@"token"]=[[NSUserDefaults standardUserDefaults] objectForKey:@"ticket"];
    }
    [MBProgressHUD showMessage:@"加载中…"];
    return  [AFUploadRequestOperation uploadFileWithUrl:url parameters:param headerFields:headerFields name:name
                                              FromDatas:bodyDatas
                                         UploadProgress:progress
                                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                                    [MBProgressHUD hideHUD];
                                                    success(task,responseObject);
                                                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                    [MBProgressHUD hideHUD];
                                                    failure(task,error);
                                                }];
    
    
    
}

+(NSString *)signStringSearch:(NSDictionary *)dict{
    //  token: 32位MD5加密串(module+cat+pager+type+tokenKey,cat可以赋空值)
    NSString *paramString=@"";
    
    
    paramString=[paramString stringByAppendingString:dict[@"pager"]];
    paramString=[paramString stringByAppendingString:dict[@"type"]];
    paramString=[paramString stringByAppendingString:@"wuchen2018tbk"];
    
    return paramString;
}

+(NSString *)signString:(NSDictionary *)dict{
    //  token: 32位MD5加密串(module+cat+pager+type+tokenKey,cat可以赋空值)
    NSString *paramString=@"";
    paramString=[paramString stringByAppendingString:dict[@"module"]];
    paramString=[paramString stringByAppendingString:dict[@"cat"]];
    paramString=[paramString stringByAppendingString:dict[@"pager"]];
    paramString=[paramString stringByAppendingString:dict[@"type"]];
    paramString=[paramString stringByAppendingString:@"wuchen2018tbk"];
    
    return paramString;
}

+(NSString *)signString:(NSDictionary *)dict date:(NSTimeInterval)date{
    NSMutableArray *stringArray = [NSMutableArray arrayWithArray:dict.allKeys];
    [stringArray sortUsingComparator: ^NSComparisonResult (NSString *str1, NSString *str2) {
        return [str1 compare:str2];
    }];
    NSString *sign = [NSString stringWithFormat:@"_date=%0.f",date];
    for (NSString *key in stringArray) {
        sign=[sign stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",key,dict[key]]];
    }
    sign=[sign stringByAppendingString:clientKey];
 
    return sign;
    
}

+(NSDictionary *)appendParam:(NSDictionary *)param{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *access_token = [userDefault objectForKey:@"token"];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *buildVersion = infoDictionary[@"CFBundleVersion"];
    NSString *versionValue = infoDictionary[@"CFBundleShortVersionString"];
    NSMutableDictionary *mutableParam;
    if (param==nil) {
        mutableParam=[NSMutableDictionary new];
    }else{
        mutableParam=[param mutableCopy];
    }
    
    mutableParam[@"versionCode"] = buildVersion;
    mutableParam[@"versionName"] = versionValue;
    mutableParam[@"platform"] = @"iOS";
    if (access_token!=nil) {
        mutableParam[@"token"] = access_token;
    }
    //    #ifdef DEBUG
    //    mutableParam[@"token"] = @"5eea59eab9448e83a9c0133606f9711f";
    //    #endif
    
    return [mutableParam copy];
}


+(NSString *)convertStringWithDictionary:(NSDictionary *)dict{
    NSString *str = [dict jsonString];
    return str;
}

@end
