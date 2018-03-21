//
//  WZNavigationController.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import <commonLib/UIImage+Utility.h>
#import <commonLib/UIColor+HexString.h>

@interface WZNavigationController ()

@end

@implementation WZNavigationController


+(void)initialize{
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"dcdfe6"] size:CGSizeMake(WZwidth, 0.5)];
    image= [[UIImage alloc] init];
    [[UINavigationBar appearance] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:image];
}



//能拦截所有push进来的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    if ([viewController isKindOfClass: [WZAddBookViewController class]]) {
//        <#statements#>
//    }
    
    if (viewController.fd_prefersNavigationBarHidden) {
        
    }else{
        UIImage *image = [UIImage ms_imageWithColor:[UIColor colorWithHexString:@"fff"]];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        self.navigationBar.translucent = NO;
        self.navigationBar.tintColor = [UIColor colorWithHexString:@"0F9FFF"];
        [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
    if (self.viewControllers.count > 0) {//是否是栈底控制器
        viewController.hidesBottomBarWhenPushed = YES;//隐藏tab
        UIBarButtonItem *backItem =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem =backItem;
    }
    
    //修复 tabbar 样式异常
//    CGRect frame = self.tabBarController.tabBar.frame;
//    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//    self.tabBarController.tabBar.frame = frame;
    
   
    
    [super pushViewController:viewController animated:animated];
    
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[[self viewControllers] lastObject] preferredInterfaceOrientationForPresentation];
}


- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}

- (void)more
{
    [self popToRootViewControllerAnimated:YES];
}
@end
