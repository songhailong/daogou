//
//  WZButton.m
//  12123_Example
//
//  Created by che on 2018/1/24.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZButton.h"

@implementation WZButton

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, contentRect.size.height-40, contentRect.size.width, 20);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(10, 0, contentRect.size.width-20, contentRect.size.height-40);;
}

@end
