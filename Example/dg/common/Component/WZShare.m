//
//  WZShare.m
//  TVSearch_Example
//
//  Created by che on 2018/1/11.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZShare.h"
#import <WechatOpenSDK/WXApi.h>

@implementation WZShare

+(void)shareConfig{
    [WXApi registerApp:@"wx4c43a6a5c7f40fb7"];
}
@end
