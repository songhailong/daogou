//
//  MBProgressHUD+Extension.m
//  ymapp
//
//  Created by leon.deng on 15/3/20.
//  Copyright (c) 2015年 yummy77. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    [self showCommon:text icon:icon view:view delay:0.7];
}

+ (void)showDelay:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    [self showCommon:text icon:icon view:view delay:1.5];
}

+ (void)showCommon:(NSString *)text icon:(NSString *)icon view:(UIView *)view delay:(NSTimeInterval)delay
{
    if (view == nil) view = [self returnWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    // 设置图片
    UIImage *image =[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    hud.customView = imageView;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // delay秒之后再消失
    [hud hideAnimated:YES afterDelay:delay];
}

+ (void)showToast :(NSString *)text {
    UIView *view = [self returnWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.superview.backgroundColor=[UIColor blackColor];
    hud.label.superview.alpha=0.85f;
    hud.contentColor=[UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    [hud hideAnimated:YES afterDelay:1.5f];
}

+ (void)showBottomToast :(NSString *)text {
    
    UIView *view = [self returnWindow];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.superview.backgroundColor=[UIColor blackColor];
    hud.label.superview.alpha=0.85f;
    hud.contentColor=[UIColor whiteColor];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = text;
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    [hud hideAnimated:YES afterDelay:1.5f];
}


#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}
+ (void)showDelayError:(NSString *)error toView:(UIView *)view{
    [self showDelay:error icon:@"error.png" view:view];
}
+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}
+ (void)showDelaySuccess:(NSString *)success toView:(UIView *)view
{
    [self showDelay:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [self returnWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //hud.dimBackground = YES;
    return hud;
}

+ (MBProgressHUD *)showMessageWithoutBackground:(NSString *)message toView:(UIView *)view{
    if (view == nil) view = [self returnWindow];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    //hud.dimBackground = NO;
    return hud;
}



+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}
+ (void)showDelaySuccess:(NSString *)success{
    [self showDelaySuccess:success toView:nil];
}
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}
+(void)showDelayError:(NSString *)error{
    [self showDelayError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    [MBProgressHUD hideHUD];
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [self returnWindow];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}
+(UIView *)returnWindow{

    return [[UIApplication sharedApplication].windows firstObject];
}
@end
