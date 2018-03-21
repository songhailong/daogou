//
//  WZCollectionReusableModel.h
//  TVSearch_Example
//
//  Created by che on 2018/1/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WZCollectionViewModel.h"

@interface WZCollectionReusableModel : NSObject

@property (nonatomic ,copy ,readonly) NSString * identifier;

@property (nonatomic,strong) id headerModel;

@property (nonatomic,copy) NSArray<WZCollectionViewModel *> * items;

-(instancetype) initWithParam:(NSString *)identifier headerModel:(id)headerModel items:(NSArray<WZCollectionViewModel *> *)items;


@end
