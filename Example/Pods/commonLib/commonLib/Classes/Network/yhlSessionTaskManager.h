//
//  yhlSessionTaskManager.h
//  Pods
//
//  Created by yanghonglei on 16/7/8.
//
//

#import <Foundation/Foundation.h>

@interface yhlSessionTaskManager : NSObject

+ (id)sharedManager;

- (void)addGlobalTask:(NSURLSessionTask *)task;
- (void)cancelGlobalTask:(NSURLSessionTask *)task;

- (void)addTask:(NSURLSessionTask *)task forGroup:(NSString *)group;
- (void)cancelTask:(NSURLSessionTask *)task forGroup:(NSString *)group;
- (void)cancelTask:(NSURLSessionTask *)task;
- (void)cancelTasksForGroup:(NSString *)group;


@end
