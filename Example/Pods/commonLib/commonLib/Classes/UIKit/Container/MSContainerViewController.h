//
//  MSContainerViewController.h
//  YMInfo
//
//  Created by yangshiyu on 2017/2/8.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//
//一个带有menu支持点击切换，左右滑动切换controller的容器类

#import <UIKit/UIKit.h>
#import "MSNavigationView.h"

@interface MSContainerViewController : UIViewController
{
    UIView<MSNavigatorView> *_navigationView;
}

@property(nullable, nonatomic,copy) NSArray<__kindof UIViewController *> *viewControllers;
@property(nullable, nonatomic, assign,readonly) __kindof UIViewController *currentController;

@property (nullable,nonatomic, strong, readonly) UIView<MSNavigatorView> *navigationView;

@property (assign, nonatomic) NSInteger selectedIndex;

@property (assign,nonatomic) NSInteger topExtend;//

/**
 *  之类复写的时候需要调用复类的方法
 *
 *  @param index 
 */
- (void)willSelectControllerAtIndex:(NSInteger)index;

- (void)didSelectControllerAtIndex:(NSInteger)index;

-(void) reLoadDataSources;

@end
