//
//  DGListModel.h
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCellModel.h"

@interface DGListModel : WZCellModel

@property (nonatomic,strong) NSString *couponClickUrl;
@property (nonatomic,strong) NSString *couponEndTime;
@property (nonatomic,strong) NSString *couponInfo;

@property (nonatomic,assign) NSInteger couponLessHours;
@property (nonatomic,assign) NSInteger couponRemainCount;
@property (nonatomic,assign) NSInteger couponTotalCount;
@property (nonatomic,assign) NSInteger couponValue;
@property (nonatomic,assign) CGFloat prdtPrice;

@property (nonatomic,strong) NSString *couponStartTime;
@property (nonatomic,strong) NSString *prdtImgUrl;
@property (nonatomic,strong) NSString *prdtId;
@property (nonatomic,strong) NSString *prdtName;
@end
