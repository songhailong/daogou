//
//  WZEmptyView.h
//  12123_Example
//
//  Created by che on 2018/2/26.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WZEmptyViewBlock)();

@interface WZEmptyView : UIView

@property (nonatomic,copy) WZEmptyViewBlock block;

-(void)update:(NSString *)image title:(NSString *)title link:(NSString *)link isShowLink:(BOOL)isShowLink;

@end
