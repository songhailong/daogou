//
//  CCHistorySearchHeaderView.h
//  che_Example
//
//  Created by 杨红磊 on 2017/12/6.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchDeleteBlock)();

@interface CCHistorySearchHeaderView : UIView

@property (nonatomic,copy) searchDeleteBlock block;

+(instancetype)initWithXib;

@end
