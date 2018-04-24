//
//  DGListModel.h
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCellModel.h"
#import "ProductItem.h"

@interface DGListModel : WZCellModel<ProductItemProtocal>


@end

@interface DGHomeBannerModel:WZCellModel

@property (nonatomic,strong) NSString *bannerId;
@property (nonatomic,strong) NSString *bannerName;
@property (nonatomic,strong) NSString *clickUrl;
@property (nonatomic,strong) NSString *imgUrl;
@property (nonatomic,strong) NSString *endDate;
@property (nonatomic,strong) NSString *startDate;
@property (nonatomic,strong) NSString *linkParam;
@property (nonatomic,strong) NSString *linkShowType;//页面展示模式：one-一行一商品，two-一行两个商品,twocross-一行两个商品交错
@property (nonatomic,strong) NSString *linkTitle;
@property (nonatomic,strong) NSString *linkType;
@end
