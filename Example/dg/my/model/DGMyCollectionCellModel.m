//
//  DGMyCollectionCellModel.m
//  dg_Example
//
//  Created by che on 2018/4/24.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGMyCollectionCellModel.h"
#import "DGMycollectionTableViewCell.h"

@implementation DGMyCollectionCellModel
@synthesize couponClickUrl;
@synthesize couponEndTime;
@synthesize couponInfo;
@synthesize couponLessHours;
@synthesize couponRemainCount;
@synthesize couponStartTime;
@synthesize couponTotalCount;
@synthesize couponValue;
@synthesize prdtId;
@synthesize prdtImgUrl;
@synthesize prdtName;
@synthesize prdtPrice;
@synthesize prdtUrl;

- (instancetype)init {
    if (self = [super init]) {
        self.Class             = [DGMycollectionTableViewCell class];
        self.reuseIdentify     = @"DGMycollectionTableViewCell";
        self.isRegisterByClass = NO;
    }
    return self;
}

-(instancetype)parse:(NSDictionary *)info options:(NSUInteger)options{
    [self ms_reflectDataRecursionFromOtherDictionary:info];
    return self;
}

@end
