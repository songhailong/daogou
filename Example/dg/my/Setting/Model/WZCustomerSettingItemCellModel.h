//
//  WZCustomerSettingItemCellModel.h
//  12123_Example
//
//  Created by che on 2018/1/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCellModel.h"

@interface WZCustomerSettingItemCellModel : WZCellModel

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,assign) BOOL isLogout;

@end
