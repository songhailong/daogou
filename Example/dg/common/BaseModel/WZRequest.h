//
//  WZRequest.h
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <commonLib/yhlSessionManager.h>
#import <commonLib/AFDownloadUploadOperation.h>
#import "WZResponse.h"

@interface WZRequest : NSObject
+ ( NSURLSessionDataTask *)defaultPOST:( NSString *)URLString
                     parameters:( NSDictionary *)parameters
                   headerFields:( id)headerFields
                     completion:( WZResponseObjectBlock)completeBlock;
+ ( NSURLSessionDataTask *)POST:( NSString *)URLString
                     parameters:( NSDictionary *)parameters
                   headerFields:( id)headerFields
                     completion:( WZResponseObjectBlock)completeBlock;

+ ( NSURLSessionDataTask *)BACKPOST:( NSString *)URLString
                         parameters:( NSDictionary *)parameters
                       headerFields:( id)headerFields
                         completion:( WZResponseObjectBlock)completeBlock;

+ ( NSURLSessionDataTask *)GET:( NSString *)URLString
                    parameters:( NSDictionary *)parameters
                  headerFields:( id)headerFields
                    completion:( JSONObjectBlock)completeBlock;

+ ( NSURLSessionDataTask *)BACKGET:( NSString *)URLString
                        parameters:( NSDictionary *)parameters
                      headerFields:( id)headerFields
                        completion:( JSONObjectBlock)completeBlock;

+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url parameters:(id)parameters name:(NSString *)name
                                   FromData:(NSArray *)bodyDatas
                             UploadProgress:(NetworkProgress)progress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
