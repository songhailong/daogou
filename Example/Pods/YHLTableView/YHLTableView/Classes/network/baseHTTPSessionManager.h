//
//  baseHTTPSessionManager.h
//  Pods
//
//  Created by yangshiyu on 2017/2/13.
//
//

#import <AFNetworking/AFNetworking.h>

@class baseHTTPResponse;


extern NSString * const baseHTTPSessionManagerTaskDidFailedNotification;


@protocol baseHTTPErrorHandler <NSObject>

- (void)handleRequestError:(NSError *)error;

- (void)handleRequestFlowData:(NSString *)URL
                  downLoadLen:(NSUInteger)download
                    uploadLen:(NSUInteger)upload;
@end

@interface baseHTTPSessionManager : AFHTTPSessionManager



@property (nonatomic, strong) id <baseHTTPErrorHandler>errorHandler;


+ (baseHTTPSessionManager *)sharedManager;

@property (nonatomic, strong) NSDictionary *defaultHeaders;   // 附加授权信息
@property (nonatomic, strong) NSDictionary *defaultParameters;// 附加授权信息


- (NSURLSessionTask *)GET:(NSString *)URLString
                    param:(NSDictionary *)param
                    block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block __deprecated;

- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block __deprecated;

- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(NSDictionary *)param
             headerFields:(NSDictionary *)headers
                    block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;


- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;


- (NSURLSessionTask *)method:(NSString *)method
                   URLString:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
                headerFields:(NSDictionary *)headerFields
                     success:(void (^)(NSURLSessionTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionTask *task, NSError *error))failure;




@end
