//
//  WZWindow.m
//  TVSearch_Example
//
//  Created by che on 2018/1/11.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZWindow.h"
#import "WZTabBarController.h"

@interface WZWindow()<UITabBarControllerDelegate>

@end

@implementation WZWindow

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        WZTabBarController *tabBarVc = [[WZTabBarController alloc]init];
        tabBarVc.delegate = self;
        self.rootViewController = tabBarVc;
        
    }
    return self;
}

@end
