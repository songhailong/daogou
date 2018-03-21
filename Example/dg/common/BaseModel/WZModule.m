//
//  WZModule.m
//  TVSearch
//
//  Created by 万圣伟业 on 2017/2/28.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "WZModule.h"
#import "WZAppSetting.h"
#import <commonLib/MSAppModuleController.h>
#import <MSAppModuleWebApp/MSAppModuleWebApp.h>
#import "JLRoutes+YM.h"
#import <UMMobClick/MobClick.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import "PINCache+YMCache.h"
#import "WZNewVersionModel.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "BaiduMobStat.h"
@implementation WZModule



+(void)setupUI{
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    keyboardManager.shouldShowToolbarPlaceholder = NO;
}





+(void)moduleRegister{
    WZAppSetting *appSettings = [WZAppSetting appSettings];
    [MSAppModuleController appModuleControllerWithSettings:appSettings];
    [appModuleManager addModule:[MSAppModuleWebApp new]];
    [[JLRoutes appRoutes] registerRoutes];
}









+(void)checkVersion{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WZNewVersionModel checkVersionRequest];
    });
}

+(void)BaiduMTJ{
    #ifdef DEBUG
    
    #else
        [[BaiduMobStat defaultStat] startWithAppId:@"2f0cbb3a63"];
    #endif
}

@end
