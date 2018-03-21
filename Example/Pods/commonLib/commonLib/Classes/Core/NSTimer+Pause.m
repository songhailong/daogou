//
//  NSTimer+Pause.m
//  EMStock
//
//  Created by ryan on 15/8/24.
//  Copyright (c) 2015年 flora. All rights reserved.
//

#import "NSTimer+Pause.h"

@implementation NSTimer (Pause)

- (void)pause {
    if (![self isValid]) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]]; //如果给我一个期限，我希望是4001-01-01 00:00:00 +0000
}


- (void)resume {
    [self resumeInDate:[NSDate date]];
}

- (void)resumeInDate:(NSDate *)date {
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:date];
}


+ (NSTimer*)yhl_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)())block
                                       repeats:(BOOL)repeats
{
    return [self scheduledTimerWithTimeInterval:interval
                                         target:self
                                       selector:@selector(eoc_blockInvoke:)
                                       userInfo:[block copy]
                                        repeats:repeats];
    
}


+ (void)eoc_blockInvoke:(NSTimer*)timer {
    void (^block)() = timer.userInfo;
    if (block) {
        block();
    }
}

@end
