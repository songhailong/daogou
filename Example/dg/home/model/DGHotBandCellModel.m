//
//  DGHotBandCellModel.m
//  dg_Example
//
//  Created by che on 2018/4/8.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGHotBandCellModel.h"

@implementation DGHotBandCellModel

-(instancetype)init{
    self =[super init];
    if (self) {
        self.identifier=@"DGHotBandCollectionViewCell";
    }
    return self;
}


-(instancetype)parse:(NSDictionary *)info options:(NSUInteger)options{
    [self ms_reflectDataRecursionFromOtherDictionary:info];
    
    return self;
}
@end
