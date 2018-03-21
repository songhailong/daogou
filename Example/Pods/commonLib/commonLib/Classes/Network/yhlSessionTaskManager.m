//
//  yhlSessionTaskManager.m
//  Pods
//
//  Created by yanghonglei on 16/7/8.
//
//

#import "yhlSessionTaskManager.h"

#define MSSessionTaskManagerKey_Global @"globalSessionTask"

@implementation yhlSessionTaskManager
{
    NSMutableDictionary *_tasks;
}

+ (id)sharedManager
{
    static dispatch_once_t onceQueue;
    static yhlSessionTaskManager *sessionTaskManager = nil;
    
    dispatch_once(&onceQueue, ^{ sessionTaskManager = [[self alloc] init]; });
    return sessionTaskManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        _tasks = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSMutableArray *)_tasksForKey:(NSString *)key
{
    NSMutableArray *tasks = _tasks[key];
    if (tasks == nil && key && key.length) {
        _tasks[key] = [NSMutableArray array];
        tasks = _tasks[key];
    }
    return tasks;
}

- (void)addGlobalTask:(NSURLSessionTask *)task
{
    NSMutableArray *tasks = [self _tasksForKey:MSSessionTaskManagerKey_Global];
    [tasks addObject:task];
}

- (void)cancelGlobalTask:(NSURLSessionTask *)task
{
    [task cancel];
    NSMutableArray *tasks = [self _tasksForKey:MSSessionTaskManagerKey_Global];
    [tasks removeObject:task];
}

- (void)addTask:(NSURLSessionTask *)task forGroup:(NSString *)group
{
    NSMutableArray *tasks = [self _tasksForKey:group];
    [tasks addObject:task];
}

- (void)cancelTask:(NSURLSessionTask *)task forGroup:(NSString *)group
{
    [task cancel];
    NSMutableArray *tasks = [self _tasksForKey:group];
    [tasks removeObject:tasks];
}

- (void)cancelTasksForGroup:(NSString *)group
{
    NSMutableArray *tasks = [self _tasksForKey:group];
    [tasks makeObjectsPerformSelector: @selector(cancel)];
    [_tasks removeObjectForKey:group];
}

- (void)cancelTask:(NSURLSessionTask *)task
{
    [task cancel];
    
    for (NSMutableArray *tasks in _tasks.allValues)
    {
        if ([tasks containsObject:task]) {
            [tasks removeObject:task];
            break;
        }
    }
}

@end

