//
//  baseHTTPRequestModel.h
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import <Foundation/Foundation.h>
#import "baseHTTPResponse.h"

@protocol baseHTTPRequestModel <NSObject>

- (void)cancelTasks;

@end

@interface baseHTTPRequestModel : NSObject<baseHTTPRequestModel>{
     NSMutableArray *_tasks;
}

@property (nonatomic, strong, getter=getTasks) NSMutableArray *tasks;
@property (nonatomic, strong) NSDictionary *defaultParameters;

- (NSURLSessionTask *)GET:(NSString *)URLString
                    param:(NSDictionary *)param
                    block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;


- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(NSDictionary *)param
             headerFields:(NSDictionary *)headers
                    block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block;

- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(baseHTTPResponse *, NSURLSessionTask *, BOOL))block;

/**
 *  @param response  经过解析的EMHTTResponse对象
 *  @param URLString HTTP请求的URL
 *
 *  @return 是否解析成功
 */
- (BOOL)parseHTTPResponse:(baseHTTPResponse *)response
                      URL:(NSString *)URLString;

/**
 *  取消请求任务
 */
- (void)cancelTasks;

@end
