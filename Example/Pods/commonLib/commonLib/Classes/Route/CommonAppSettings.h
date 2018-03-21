//
//  CommonAppSettings
//  EMStock
//
//  Created by ryan on 15/11/5.
//  Copyright © 2015年 flora. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommonAppSettings <NSObject>


@end


@interface CommonAppSettings : NSObject <CommonAppSettings>

+ (instancetype)appSettings;

@end
