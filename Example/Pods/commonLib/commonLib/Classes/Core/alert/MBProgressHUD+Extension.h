//
//  MBProgressHUD+Extension.h
//  ymapp
//
//  Created by leon.deng on 15/3/20.
//  Copyright (c) 2015年 yummy77. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showDelaySuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showDelayError:(NSString *)error toView:(UIView *)view;


+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showMessageWithoutBackground:(NSString *)message toView:(UIView *)view;

+ (void)showSuccess:(NSString *)success;
+ (void)showDelaySuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showDelayError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;


+ (void)showToast :(NSString *)text;
+ (void)showBottomToast :(NSString *)text;
@end
