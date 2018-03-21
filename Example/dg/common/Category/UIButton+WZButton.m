//
//  UIButton+WZButton.m
//  12123_Example
//
//  Created by che on 2018/1/24.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "UIButton+WZButton.h"

@implementation UIButton (WZButton)

//不论按钮有多宽 文字在按钮的最左边 图片在最右边
-(void) resetLayout{
    
    UIImage *image = self.currentImage;
    CGRect frame = self.titleLabel.frame;
    
    CGFloat titleX = (self.frame.size.width - frame.size.width + image.size.width)*0.5;
    CGFloat imageX = (self.frame.size.width - image.size.width + frame.size.width)*0.5;

    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -titleX, 0,titleX)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, imageX, 0, -imageX)];
   
}

//文字和按钮仅仅调换位置 但还是居中展示
-(void) resetLayout2{
        UIImage *image = self.currentImage;
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width-10, 0, image.size.width+10)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.frame.size.width, 0, -self.titleLabel.frame.size.width)];
}

//文字居中 图片在最右边
-(void) resetLayout3{
    UIImage *image = self.currentImage;
    CGRect frame = self.titleLabel.frame;
    
    CGFloat imageX = (self.frame.size.width - image.size.width + frame.size.width)*0.5;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width-10, 0, image.size.width+10)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, imageX, 0, -imageX)];
}

@end
