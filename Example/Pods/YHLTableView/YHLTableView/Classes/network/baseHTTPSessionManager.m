//
//  baseHTTPSessionManager.m
//  Pods
//
//  Created by yangshiyu on 2017/2/13.
//
//

#import "baseHTTPSessionManager.h"
#import "baseURLProtocol.h"
#import "baseHTTPResponse.h"
NSString * const baseHTTPSessionManagerTaskDidFailedNotification = @"com.meiti.task.failed";

@implementation baseHTTPSessionManager

+ (baseHTTPSessionManager *)sharedManager
{
    static baseHTTPSessionManager *__manager = nil;
    @synchronized(self)
    {
        if (__manager == nil) {
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            
            BOOL isAddCustomProtocol = [[NSUserDefaults standardUserDefaults] boolForKey:kMSURLPROTOCOLFORSERVERADDRESSKEY];
            if (isAddCustomProtocol) {
                config.protocolClasses = @[[baseURLProtocol class]];
            }
            
            config.timeoutIntervalForRequest = 30;
            __manager = [[baseHTTPSessionManager alloc] initWithSessionConfiguration:config];
            __manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"application/octet-stream", nil];
            
            if ([__manager.responseSerializer isKindOfClass:[AFJSONResponseSerializer class]])
            {
                AFJSONResponseSerializer *serializer = (AFJSONResponseSerializer *)__manager.responseSerializer;
                serializer.removesKeysWithNullValues = YES;
            }
        }
    }
    return __manager;
}

- (NSURLSessionTask *)GET:(NSString *)URLString
                    param:(NSDictionary *)param
                    block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    return [self GET:URLString parameters:param headerFields:nil block:block];
}


- (NSURLSessionTask *)POST:(NSString *)URLString
                     param:(NSDictionary *)param
                     block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    return [self POST:URLString parameters:param headerFields:nil block:block];
}


- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(NSDictionary *)param
             headerFields:(NSDictionary *)headers
                    block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block {
    NSURLSessionTask *task = [self method:@"GET" URLString:URLString parameters:param headerFields:headers success:^(NSURLSessionTask *task, id responseObject) {
        baseHTTPResponse *response = [baseHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:baseHTTPSessionManagerTaskDidFailedNotification object:task];
        baseHTTPResponse *response = [baseHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    return task;
}

- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    NSURLSessionTask *task = [self method:@"POST" URLString:URLString parameters:param headerFields:headers success:^(NSURLSessionTask *task, id responseObject) {
        baseHTTPResponse *response = [baseHTTPResponse responseWithObject:responseObject];
        block(response, task, YES);
    } failure:^(NSURLSessionTask *task, NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:baseHTTPSessionManagerTaskDidFailedNotification object:task];
        baseHTTPResponse *response = [baseHTTPResponse responseWithError:error];
        block(response, task, NO);
    }];
    
    return task;
}

- (NSURLSessionTask *)method:(NSString *)method
                   URLString:(NSString *)URLString
                  parameters:(NSDictionary *)parameters
                headerFields:(NSDictionary *)headerFields
                     success:(void (^)(NSURLSessionTask *task, id responseObject))success
                     failure:(void (^)(NSURLSessionTask *task, NSError *error))failure {
    
    NSError *serializationError = nil;
    
    baseHTTPSessionManager *manager = self;
    
    NSUInteger uploadLen = 0;
    
    NSMutableDictionary *newParameters = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (self.defaultParameters) {
        [newParameters addEntriesFromDictionary:self.defaultParameters];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newParameters];
        uploadLen = [data length];
    }
    
    //URLString = [self addParamToURL:URLString dict:newParameters];
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:URLString parameters:newParameters error:&serializationError];
    
    if (self.defaultHeaders) {
        for (NSString *key in [self.defaultHeaders allKeys])
        {
            [request setValue:[self.defaultHeaders objectForKey:key] forHTTPHeaderField:key];
        }
    }
    
    for (NSString *key in [headerFields allKeys])
    {
        [request setValue:[headerFields objectForKey:key] forHTTPHeaderField:key];
    }
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(manager.completionQueue ?: dispatch_get_main_queue(), ^{
                [self failureRequest:serializationError];
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionTask *dataTask = nil;
    dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                [[NSNotificationCenter defaultCenter] postNotificationName:baseHTTPSessionManagerTaskDidFailedNotification object:dataTask];
                [self failureRequest:error];
                failure(dataTask, error);
            }
        } else {
            if (success) {
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:newParameters];
                NSUInteger downloadLen = [data length];
                
                if (self.errorHandler && [self.errorHandler respondsToSelector:@selector(handleRequestFlowData:downLoadLen:uploadLen:)]) {
                    [self.errorHandler handleRequestFlowData:URLString
                                                 downLoadLen:downloadLen
                                                   uploadLen:uploadLen];
                }
                success(dataTask, responseObject);
            }
        }
    }];
    
    [dataTask resume];
    return dataTask;
}

- (void)failureRequest:(NSError *)error
{
    if (error.code == NSUserCancelledError) {
        return;
    }
    
    if (self.errorHandler && [self.errorHandler respondsToSelector:@selector(handleRequestError:)]) {
        [self.errorHandler handleRequestError:error];
    }
}

-(NSString *)addParamToURL:(NSString *)Url dict:(NSDictionary *)dict{
    
    for (NSString *key in dict.allKeys) {
        Url=[Url stringByAppendingString:[NSString stringWithFormat:@"/%@/%@",key,dict[key]]];
    }
    
    
    
    return Url;
}

@end
