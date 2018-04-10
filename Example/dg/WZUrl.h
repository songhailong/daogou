//
//  WZUrl.h
//  12123
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#ifndef WZUrl_h
#define WZUrl_h


#define apptoken @"wuchen2018tbk"


//java
//#define YMdomain @"http://112.29.171.12:8080"
#define YMdomain @"http://it.cityym.com:8080"

#define kMobileAPIFormat_M(fmt, ...) [YMdomain stringByAppendingFormat:fmt, ##__VA_ARGS__]


//
#define yhqfirstpagergetaction kMobileAPIFormat_M(@"/yhq/firstpager.get.action")
//热卖品牌
#define yhqbrandgetaction kMobileAPIFormat_M(@"/yhq/brand.get.action")
//获取商品列表
#define yhqcoupongetaction kMobileAPIFormat_M(@"/yhq/coupon.get.action")
//搜索商品
#define yhqcouponsearchaction kMobileAPIFormat_M(@"/yhq/coupon.search.action")
//提交邀请码
#define yhqinvitcodesubmitaction kMobileAPIFormat_M(@"/yhq/invitcode.submit.action")
//获取用户邀请码
#define yhqinvitcodegetaction kMobileAPIFormat_M(@"/yhq/invitcode.get.action")
//发送登录用户信息到服务端
#define yhqtbaccountsubmitaction kMobileAPIFormat_M(@"/yhq/tbaccount.submit.action")

//


#endif /* WZUrl_h */

//lihu0800205@icloud.com
