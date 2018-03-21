//
//  UIView+WZXibView.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "UIView+WZXibView.h"

@implementation UIView (WZXibView)

+(instancetype)initWithXib{
    return [[NSBundle mainBundle] loadNibNamed: NSStringFromClass(self) owner:nil options:nil].firstObject;
}

+(instancetype)initWithXibWithFrame:(CGRect)frame{
    UIView *view = [[NSBundle mainBundle] loadNibNamed: NSStringFromClass(self) owner:nil options:nil].firstObject;
    view.frame=frame;
    return view;
}

@end
