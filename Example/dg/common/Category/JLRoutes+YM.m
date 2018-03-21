//
//  JLRoutes+YM.m
//  YMInfo
//
//  Created by 万圣伟业 on 2017/2/21.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "JLRoutes+YM.h"
#import <commonLib/MSActiveControllerFinder.h>
#import <commonLib/UIViewController+Routes.h>
@implementation JLRoutes (YM)

+ (instancetype)appRoutes {
    return [JLRoutes globalRoutes];
}


- (void)registerRoutes {
    [self registerWebView];
}

// TODO 板块
- (void)registerWebView {
    [self addRoute:@"web" handler:^BOOL (NSDictionary *parameters) {
        UINavigationController *navController = [MSActiveControllerFinder finder].activeNavigationController();
        [MSActiveControllerFinder finder].resetStatus();
        [navController pushViewControllerClass:NSClassFromString(@"YMWebViewController") params:parameters];
        return YES;
    }];
}
@end
