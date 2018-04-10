//
//  ALiTradeSDKShareParam.m
//  NBSDK
//
//  Created by com.alibaba on 16/5/31.
//  Copyright © 2016年 com.alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALiTradeSDKShareParam.h"
@interface ALiTradeSDKShareParam()

@end

@implementation ALiTradeSDKShareParam
+ (instancetype)sharedInstance
{
    static ALiTradeSDKShareParam* instance ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ALiTradeSDKShareParam alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.customParams = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"hello",@"pvid",@"world",@"scm",@"vedio",@"page",@"baichuan",@"subplat",@"trade",@"label",@"ling",@"puid",@"feng",@"pguid",nil];

        self.externParams = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"taobaoH5", @"_viewType",@"tag1",@"isv_code",@"xxxxxxxxxx",@"ybhpss",nil];

        //adzoneid不为空的情况回归
        //mm_100713040_22792955_75330474
        //mm_127970548_0_0
        self.taoKeParams = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"mm_127970548_0_0", @"pid",@"",@"unionId",@"", @"subPid", @"59786713",@"adzoneId",@{@"taokeAppkey":[NSString stringWithFormat:@"%d",alappkey]},@"extParams",nil];
        self.globalTaoKeParams = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"mm_100713040_22792955_75330474", @"pid",@"",@"unionId",@"", @"subPid",@"", @"adzoneId",nil];
 
 /*
        //adzoneid为空，只有pid的情况回归
        self.taoKeParams = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"mm_100713040_22792955_75330474", @"pid",@"",@"unionId",@"", @"subPid",nil];
        self.globalTaoKeParams = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"mm_100713040_22792955_75330474", @"pid",@"",@"unionId",@"",@"subPid",nil];
   */
  
        self.backUrl= [NSString stringWithFormat:@"tbopen%d",alappkey];
        self.openType=0;
        self.linkKey=0;
        self.isNeedPush=NO;
        self.isBindWebview=NO;
        self.NativeFailMode=0;
        self.isUseTaokeParam=YES;
    
    }
    return self;
}



@end
