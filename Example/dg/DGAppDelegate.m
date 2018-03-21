//
//  DGAppDelegate.m
//  dg
//
//  Created by 272789124@qq.com on 03/14/2018.
//  Copyright (c) 2018 272789124@qq.com. All rights reserved.
//

#import "DGAppDelegate.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "WZWindow.h"

@implementation DGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[WZWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    [self application:application];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application {
    // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
    [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
         NSLog(@"success : ");
    } failure:^(NSError *error) {
        NSLog(@"Init failed: %@", error.description);
    }];
    
    // 开发阶段打开日志开关，方便排查错误信息
    //默认调试模式打开日志,release关闭,可以不调用下面的函数
    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];
    
    // 配置全局的淘客参数
    //如果没有阿里妈妈的淘客账号,setTaokeParams函数需要调用
    
//    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
//    taokeParams.pid = @"mm_XXXXX"; //mm_XXXXX为你自己申请的阿里妈妈淘客pid
//    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
    
    //设置全局的app标识，在电商模块里等同于isv_code
    //没有申请过isv_code的接入方,默认不需要调用该函数
//    [[AlibcTradeSDK sharedInstance] setISVCode:@"your_isv_code"];
    
    // 设置全局配置，是否强制使用h5
    [[AlibcTradeSDK sharedInstance] setIsForceH5:NO];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    /* 老接口写法 已弃用，建议使用新接口
     if (![[AlibcTradeSDK sharedInstance] handleOpenURL:url]) {
     // 处理其他app跳转到自己的app
     }
     return YES;
     */
    
    // 新接口写法
    if (![[AlibcTradeSDK sharedInstance] application:application
                                             openURL:url
                                   sourceApplication:sourceApplication
                                          annotation:annotation]) {
        // 处理其他app跳转到自己的app
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    /* 老接口写法 已弃用，建议使用新接口
     if (![[AlibcTradeSDK sharedInstance] handleOpenURL:url]) {
     // 处理其他app跳转到自己的app
     }
     return YES;
     */
    
    // 新接口写法
    if (![[AlibcTradeSDK sharedInstance] application:application
                                             openURL:url
                                             options:options]) {
        //处理其他app跳转到自己的app，如果百川处理过会返回YES
    }
    return YES;
}

@end
