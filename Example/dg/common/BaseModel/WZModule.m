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

+(void)uploadUserInfo:(NSString *)tbaccount tbname:(NSString *)tbname{
    
    NSString *userinfo = [[PINCache sharedCache] objectForKey:@"userinfo"];
    if (userinfo!=nil&&[userinfo containsString:tbname]) {
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSString *imei=[[UIDevice currentDevice] identifierForVendor].UUIDString;
    param[@"imei"]=imei;
    param[@"type"]=@"IOS";
    param[@"tbaccount"]=tbaccount;
    param[@"tbname"]=tbname;
    NSString *signString = [self signStringSearch:param];
    param[@"token"] = [signString md5String];
    [WZRequest GET:yhqtbaccountsubmitaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        if (json!=nil) {
            [[PINCache sharedCache] setObject:tbname forKey:@"userinfo"];
            
        }
    }];
}


+(NSString *)signStringSearch:(NSDictionary *)dict{
    NSString *paramString=@"";
    paramString=[paramString stringByAppendingString:dict[@"imei"]];
    paramString=[paramString stringByAppendingString:dict[@"tbaccount"]];
    paramString=[paramString stringByAppendingString:dict[@"tbname"]];
    paramString=[paramString stringByAppendingString:apptoken];
    
    return paramString;
}

@end
