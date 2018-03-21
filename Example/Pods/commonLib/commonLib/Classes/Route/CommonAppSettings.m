//
//  CommonAppSettings
//  EMStock
//
//  Created by ryan on 15/11/5.
//  Copyright © 2015年 flora. All rights reserved.
//

#import "CommonAppSettings.h"

@implementation CommonAppSettings

+ (instancetype)appSettings {
    static CommonAppSettings *settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[self alloc] init];
    });
    return settings;
}


@end
