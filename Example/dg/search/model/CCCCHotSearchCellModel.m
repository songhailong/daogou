//
//  CCCCHotSearchCellModel.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/5.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCCCHotSearchCellModel.h"
#import "CCHotSearchTableViewCell.h"
#import "CCHistorySearchTableViewCell.h"
#import "CCSearchItemTableViewCell.h"

@implementation CCCCHotSearchCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.Class             = [CCHotSearchTableViewCell class];
        self.reuseIdentify     = @"CCHotSearchTableViewCell";
        self.isRegisterByClass = NO;
    }
    return self;
}

@end

@implementation CCHistorySearchCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.Class             = [CCHistorySearchTableViewCell class];
        self.reuseIdentify     = @"CCHistorySearchTableViewCell";
        self.isRegisterByClass = NO;
    }
    return self;
}

@end

@implementation CCSearchItemCellModel

- (instancetype)init {
    if (self = [super init]) {
        self.Class             = [CCSearchItemTableViewCell class];
        self.reuseIdentify     = @"CCSearchItemTableViewCell";
        self.isRegisterByClass = NO;
    }
    return self;
}

@end


