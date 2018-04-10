//
//  CCSearchHeaderView.h
//  che_Example
//
//  Created by 杨红磊 on 2017/12/6.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^searchHeaderBlock)(NSInteger index);

@interface CCSearchHeaderView : UIView
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property (nonatomic,copy) searchHeaderBlock block;

+(instancetype)initWithXib;
@end
