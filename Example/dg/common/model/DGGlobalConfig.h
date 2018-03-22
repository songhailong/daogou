//
//  DGGlobalConfig.h
//  dg_Example
//
//  Created by che on 2018/3/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "MyAlertView.h"
#import <AlibabaAuthSDK/albbsdk.h>
#import <AlibcTradeSDK/AlibcTradeShowParams.h>
#import "ALiTradeWebViewController.h"
#import "ALiTradeSDKShareParam.h"
@interface DGGlobalConfig : NSObject

+(NSDictionary *)customParam;

+(AlibcTradeTaokeParams*)taokeParam;

+(NSString*)schemeType;

+(AlibcNativeFailMode )NativeFailMode;

+(AlibcOpenType)openType;
@end
