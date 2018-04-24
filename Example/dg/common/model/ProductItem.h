//
//  ProductItem.h
//  dg
//
//  Created by che on 2018/4/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#ifndef ProductItem_h
#define ProductItem_h

@protocol ProductItemProtocal <NSObject>

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
@property (nonatomic,strong) NSString *prdtUrl;
@property (nonatomic,strong) NSString *prdtName;

@end
#endif /* ProductItem_h */
