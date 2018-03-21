//
//  WZPush.m
//  12123_Example
//
//  Created by che on 2018/3/12.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZPush.h"
#import "PINCache+YMCache.h"
#import <commonLib/MSActiveControllerFinder.h>
#import "WZWebViewController.h"
// 引入JPush功能所需头文件
#import <JPush/JPUSHService.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用idfa功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>

#ifdef DEBUG
#define isProduction 0
#else
#define isProduction 1
#endif

@interface WZPush ()<JPUSHRegisterDelegate>
@end

@implementation WZPush


+(instancetype)sharedPush{
    static WZPush *wzpush;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        wzpush = [[WZPush alloc] init];
    });
    return wzpush;
}


-(void)pushInit:(NSDictionary *)launchOptions{
    //推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    [JPUSHService setupWithOption:launchOptions appKey:@"f3c4142a9b6c8ae4c6d7bf6f" channel:@"App Store"
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    // 自定义消息推送
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    
    
    [JPUSHService setLogOFF];
}

+(void)registerToken:(NSData *)deviceToken{
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    [JPUSHService registrationID];
}

+(void)handleRemoteNotification:(NSDictionary *)userInfo{
    [JPUSHService handleRemoteNotification:userInfo];
}

// 自定义消息推送
// 接收到通知事件
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    //NSDictionary *userInfo = [notification userInfo];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    [WZPush notificationHandle:userInfo applicationState:2];//通知消息处理
    //处理万一蒙版不关闭的情况
    [self closeBg];
//    if ( [UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {
//        NSLog(@"UIApplicationStateActive");
//    } else if([UIApplication sharedApplication].applicationState == UIApplicationStateBackground){
//       NSLog(@"UIApplicationStateBackground");
//    }else{
//
//    }
    
  
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

+(void)notificationHandle:(NSDictionary *)dict applicationState:(UIApplicationState)applicationState
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    
    NSString *target = dict[@"target"];
    if (target!=nil) {
        MSActiveControllerFinder *finder = [MSActiveControllerFinder finder];
        UINavigationController *nav = finder.activeNavigationController();
        if ([target containsString:@"message"]) {
            if (nav!=nil) {
//                WZCustomerMessageViewController *vc = [[WZCustomerMessageViewController alloc] init];
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [nav pushViewController:vc animated:YES];
//                });
            }else{
                NSLog(@"a");
            }
        }else if ([target containsString:@"web"]){
            NSString *url = dict[@"url"];
            if (url!=nil) {
                if (nav!=nil) {
                    WZWebViewController *webVC = [[WZWebViewController alloc] initWithURL:[NSURL URLWithString:url]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [nav pushViewController:webVC animated:YES];
                    });
                    
                }else{
                    NSLog(@"a");
                }
            }
        }
    }
}

-(void)gitsterAlias{
//    NSDictionary *userInfo = [[PINCache sharedCache] objectForKey:WZUserInfoCache];
//    if (userInfo==nil) {
//        return;
//    }
//    
//    NSDictionary *param = @{@"user_id":@"123",@"app_id":@"1002",@"alias":@"",@"brand":@"jpush",@"client_type":@"ios"};
//    [WZRequest POST:kinsidepushuserURL parameters:param headerFields:nil completion:^(WZResponse * _Nullable response) {
//        if (response.success) {
//            
//        }
//    }];
}

-(void)closeBg{
    NSArray *views = [[UIApplication sharedApplication].keyWindow subviews];
    for (UIView *subView in views) {
        if ([subView isKindOfClass:[UIImageView class]] ) {
            [subView removeFromSuperview];
        }
    }
}
@end
