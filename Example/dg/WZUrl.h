//
//  WZUrl.h
//  12123
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#ifndef WZUrl_h
#define WZUrl_h

//java
#define YMdomain @"http://112.29.171.12:8080"

#define kMobileAPIFormat_M(fmt, ...) [YMdomain stringByAppendingFormat:fmt, ##__VA_ARGS__]

//Account==============================
//登录 获取验证码
#define yhqcoupongetaction kMobileAPIFormat_M(@"/yhq/coupon.get.action")
#define yhqcouponsearchaction kMobileAPIFormat_M(@"/yhq/coupon.search.action")


#endif /* WZUrl_h */
