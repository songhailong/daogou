//
//  NSDate+WZDate.m
//  12123_Example
//
//  Created by che on 2018/1/25.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "NSDate+WZDate.h"
#import <NSDate-Additions/NSDate+Additions.h>
@implementation NSDate (WZDate)

- (NSCalendar *)calendar
{
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    } else {
        return [NSCalendar currentCalendar];
    }
}

-(NSString *)format{
    NSString *lastTime = @"";
    
    NSDateFormatter *fmt_=[[NSDateFormatter alloc] init];
    fmt_.dateFormat = @"yyyy-MM-dd HH:mm:ss";
   
     NSCalendar *calendar_ =[self calendar];
    
    if (self.isThisYear) { // 今年
        if (self.isToday) { // 今天
            // 手机当前时间
            NSDate *nowDate = [NSDate date];
            NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar_ components:unit fromDate:self toDate:nowDate options:0];
            
            if (cmps.hour >= 1) { // 时间间隔 >= 1小时
                lastTime = [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 5) { // 1小时 > 时间间隔 >= 5分钟
                lastTime = [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 5分钟 > 分钟
                lastTime = @"刚刚";
            }
        } else if (self.isYesterday) { // 昨天
            fmt_.dateFormat = @"昨天 HH:mm";
            lastTime = [fmt_ stringFromDate:self];
        }else if (self.isPreYesterday) { // 前天
            fmt_.dateFormat = @"前天 HH:mm";
            lastTime = [fmt_ stringFromDate:self];
        } else { // 其他
            fmt_.dateFormat = @"MM-dd HH:mm";
            lastTime = [fmt_ stringFromDate:self];
        }
    } else { // 非今年
        fmt_.dateFormat = @"yyyy-MM-dd";
        lastTime = [fmt_ stringFromDate:self];
    }
    
    return lastTime;
}

/**
 * 是否为前天
 */
- (BOOL)isPreYesterday
{
    //实现
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 获得只有年月日的时间
    NSString *nowString = [fmt stringFromDate:[NSDate date]];
    NSDate *nowDate = [fmt dateFromString:nowString];
    
    NSString *selfString = [fmt stringFromDate:self];
    NSDate *selfDate = [fmt dateFromString:selfString];
    
    // 比较
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cmps = [calendar components:unit fromDate:selfDate toDate:nowDate options:0];
    
    return cmps.year == 0
    && cmps.month == 0
    && cmps.day == 2;
}

@end
