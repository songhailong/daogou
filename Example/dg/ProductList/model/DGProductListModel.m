//
//  DGProductListModel.m
//  dg_Example
//
//  Created by che on 2018/4/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGProductListModel.h"

@implementation DGProductListModel

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

-(instancetype)init{
    self =[super init];
    if (self) {
        self.identifier=@"DGProductListCollectionViewCell";
    }
    return self;
}


-(instancetype)parse:(NSDictionary *)info options:(NSUInteger)options{
    [self ms_reflectDataRecursionFromOtherDictionary:info];
    
    return self;
}
@end

@implementation DGProductListOneModel
-(instancetype)init{
    self =[super init];
    if (self) {
        self.identifier=@"DGProductListOneCollectionViewCell";
    }
    return self;
}

@end
