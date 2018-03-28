//
//  WZCustomerSettingItemCellModel.m
//  12123_Example
//
//  Created by che on 2018/1/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCustomerSettingItemCellModel.h"
#import "WZCustomerSettingTableViewCell.h"

@implementation WZCustomerSettingItemCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.Class             = [WZCustomerSettingTableViewCell class];
        self.reuseIdentify     = @"WZCustomerSettingTableViewCell";
        self.isRegisterByClass = NO;
    }
    return self;
}

-(instancetype)parse:(NSDictionary *)info options:(NSUInteger)options{
    [self ms_reflectDataRecursionFromOtherDictionary:info];
    return self;
}

@end
