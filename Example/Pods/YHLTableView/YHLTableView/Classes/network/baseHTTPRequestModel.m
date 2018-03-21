//
//  baseHTTPRequestModel.m
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import "baseHTTPRequestModel.h"
#import "baseHTTPSessionManager.h"
@implementation baseHTTPRequestModel

@synthesize tasks = _tasks;

- (void)dealloc
{
    [self cancelTasks];
}

- (void)cancelTasks
{
    for (NSURLSessionTask *task in _tasks) {
        [task cancel];
    }
    
    [_tasks removeAllObjects];
}

- (NSMutableArray *)getTasks
{
    if (_tasks == nil) {
        _tasks = [NSMutableArray array];
    }
    
    return _tasks;
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
                    block:(void (^)(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success))block
{
    baseHTTPSessionManager *manager = [baseHTTPSessionManager sharedManager];
    
    NSMutableDictionary *newParameters = [param mutableCopy];
    if (self.defaultParameters) {
        [newParameters addEntriesFromDictionary:self.defaultParameters];
    }
    
    NSURLSessionTask *task = [manager GET:URLString parameters:newParameters headerFields:headers block:^(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        [self parseHTTPResponse:response URL:URLString];
        block(response, task, success);
        [self.tasks removeObject:task];
    }];
    
    if (task) {
        [self.tasks addObject:task];
    }
    
    return task;
}


- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(NSDictionary *)param
              headerFields:(NSDictionary *)headers
                     block:(void (^)(baseHTTPResponse *, NSURLSessionTask *, BOOL))block
{
    baseHTTPSessionManager *manager = [baseHTTPSessionManager sharedManager];
    
    NSMutableDictionary *newParameters = [param mutableCopy];
    if (self.defaultParameters) {
        [newParameters addEntriesFromDictionary:self.defaultParameters];
    }
    
    NSURLSessionTask *task = [manager POST:URLString parameters:newParameters headerFields:headers block:^(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
        [self parseHTTPResponse:response URL:URLString];
        block(response, task, success);
        [self.tasks removeObject:task];
    }];
    
    if (task) {
        [self.tasks addObject:task];
    }
    
    return task;
}

- (BOOL)parseHTTPResponse:(baseHTTPResponse *)response
                      URL:(NSString *)URLString{
    return YES;
}

@end
