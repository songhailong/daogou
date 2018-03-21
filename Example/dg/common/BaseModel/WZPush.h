//
//  WZPush.h
//  12123_Example
//
//  Created by che on 2018/3/12.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WZPush : NSObject

+(instancetype)sharedPush;

-(void)pushInit:(NSDictionary *)launchOptions;

+(void)registerToken:(NSData *)deviceToken;

+(void)handleRemoteNotification:(NSDictionary *)userInfo;

+(void)notificationHandle:(NSDictionary *)dict applicationState:(UIApplicationState)applicationState;

@end
