//
//  WZCollectionReusableModel.m
//  TVSearch_Example
//
//  Created by che on 2018/1/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCollectionReusableModel.h"

@implementation WZCollectionReusableModel

-(instancetype) initWithParam:(NSString *)identifier headerModel:(id)headerModel items:(NSArray<WZCollectionViewModel *> *)items{
    self = [self init];
    if (self) {
        _identifier=identifier;
        _headerModel=headerModel;
        _items=items;
    }
    return self;
}
@end
