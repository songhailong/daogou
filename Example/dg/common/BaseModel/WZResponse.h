//
//  WZResponse.h
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YHLTableView/baseParseableObject.h>
#import "NSObject+Reflect.h"
#import <JSONModel/JSONModelError.h>
@class WZResponse;

typedef void (^WZResponseObjectBlock)(WZResponse * _Nullable response);
typedef void (^WZFailureBlock)(JSONModelError * _Nullable error);

@interface WZResponse : baseParseableObject

@property (nonatomic,assign) BOOL success;
@property (nonatomic,assign) NSInteger code;
@property (nonatomic, strong) id _Nullable data;
@property (nonatomic,copy) NSString * _Nullable msg;
@property (nonatomic,strong) JSONModelError * _Nullable error;

@property (nonatomic,assign) NSInteger statusCode;
@property (nonatomic,assign) NSInteger exceptionCode;
@property (nonatomic, strong) id _Nullable content;
@end
