//
//  YHLAlert.h
//  SAChe
//
//  Created by 万圣伟业 on 2017/5/25.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^YHLAlertBlick)();
typedef void(^YHLAlertBlockSheet)(NSInteger index);

@interface YHLAlert : NSObject

/**
 *  标题, 内容, 没有按钮的, 自动隐藏的
 *
 *  @param title   标题
 *  @param content 内容
 *
 *  @return EMSystemAlertPopupView 实例
 */
+ (void)showAlertWithTitle:(NSString *)title
                  contentText:(NSString *)content;


/**
 *  标题, 内容, 中间一个按钮
 *
 *  @param title       标题
 *  @param content     内容
 *  @param buttonTitle 按钮
 *  @param block       按钮block
 *
 *  @return EMSystemAlertPopupView 实例
 */
+ (void)showAlertWithTitle:(NSString *)title
                  contentText:(NSString *)content
                  buttonTitle:(NSString *)buttonTitle
                        block:(YHLAlertBlick)block;


/**
 *  标题, 内容, 两个按钮
 *
 *  @param title      标题
 *  @param content    内容
 *  @param leftTitle  左按钮标题
 *  @param leftBlock  左按钮block
 *  @param rigthTitle 右按钮标题
 *  @param rightBlock 右按钮block
 *
 *  @return EMSystemAlertPopupView 实例
 */
+ (void)showAlertinitWithTitle:(NSString *)title
                  contentText:(NSString *)content
              leftButtonTitle:(NSString *)leftTitle
                    leftBlock:( YHLAlertBlick)leftBlock
             rightButtonTitle:(NSString *)rigthTitle
                   rightBlock:( YHLAlertBlick)rightBlock;

+ (void)showAlertControllerStyleActionSheet:(NSArray<NSString *> *)datasource block:(YHLAlertBlockSheet)block;
@end
