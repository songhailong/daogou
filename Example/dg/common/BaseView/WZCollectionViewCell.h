//
//  WZCollectionViewCell.h
//  TVSearch_Example
//
//  Created by che on 2018/1/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WZCollectionViewModel.h"

@interface WZCollectionViewCell : UICollectionViewCell

-(void)update:(WZCollectionViewModel *)data;
@end
