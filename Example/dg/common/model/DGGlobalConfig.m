//
//  DGGlobalConfig.m
//  dg_Example
//
//  Created by che on 2018/3/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGGlobalConfig.h"

@implementation DGGlobalConfig

+(NSDictionary *)customParam{
    NSDictionary *customParam=[NSDictionary dictionaryWithDictionary:[ALiTradeSDKShareParam sharedInstance].customParams];
    return customParam;
    
}

+(AlibcTradeTaokeParams*)taokeParam{
    if ([ALiTradeSDKShareParam sharedInstance].isUseTaokeParam) {
        AlibcTradeTaokeParams *taoke = [[AlibcTradeTaokeParams alloc] init];
        taoke.pid =[[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"pid"];
        taoke.subPid = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"subPid"];
        taoke.unionId = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"unionId"];
        taoke.adzoneId = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"adzoneId"];
        taoke.extParams = [[ALiTradeSDKShareParam sharedInstance].taoKeParams objectForKey:@"extParams"];
        return taoke;
    } else {
        return nil;
    }
    
}

+(NSString*)schemeType{
    NSString*  linkKey=@"tmall_scheme";
    switch ([ALiTradeSDKShareParam sharedInstance].linkKey) {
        case 0:
            linkKey=@"taobao_scheme";
            break;
        case 1:
            linkKey=@"tmall_scheme";
            break;
        default:
            break;
    }
    return linkKey;
    
}

+(AlibcNativeFailMode )NativeFailMode{
    AlibcNativeFailMode openType=AlibcNativeFailModeJumpH5;
    switch ([ALiTradeSDKShareParam sharedInstance].NativeFailMode) {
        case 0:
            openType=AlibcNativeFailModeJumpH5;
            break;
        case 1:
            openType=AlibcNativeFailModeJumpDownloadPage;
            break;
        case 2:
            openType=AlibcNativeFailModeJumpBrowser;
            break;
        case 3:
            openType=AlibcNativeFailModeNone;
            break;
        default:
            break;
    }
    return openType;
    
}


+(AlibcOpenType)openType{
    
    AlibcOpenType openType=AlibcOpenTypeAuto;
    switch ([ALiTradeSDKShareParam sharedInstance].openType) {
        case 0:
            openType=AlibcOpenTypeAuto;
            break;
        case 1:
            openType=AlibcOpenTypeNative;
            break;
        case 2:
            openType=AlibcOpenTypeH5;
            break;
            
        default:
            break;
    }
    openType=AlibcOpenTypeH5;
    return openType;
}
@end
