//
//  WZTabBarController.m
//  TVSearch_Example
//
//  Created by che on 2018/1/11.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZTabBarController.h"
#import "WZNavigationController.h"
#import <commonLib/UIImage+Utility.h>
#import <commonLib/UIColor+HexString.h>

#import "DGHomeViewController.h"
#import "DG99BaoyouViewController.h"
#import "DGSpecialViewController.h"
#import "DGCarViewController.h"
#import "DGMyViewController.h"
#import "DGBaoyouViewController.h"

@interface WZTabBarController ()<UITabBarControllerDelegate>

@end

@implementation WZTabBarController


+(void)initialize{
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithHexString:@"dcdfe6"] size:CGSizeMake(WZwidth, 0.5)];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:image];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
//    [self.tabBar setNeedsDisplay];
//    [self.tabBar setNeedsLayout];
//    [self.tabBar layoutIfNeeded];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"999999"]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor colorWithHexString:@"1a1a1a"]} forState:UIControlStateSelected];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    [self creatMainView];
    
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    WZNavigationController *nav= (WZNavigationController *)viewController;
    [nav popToRootViewControllerAnimated:YES];
    
    return YES;
}



#pragma mark 初始化子视图
-(void) creatMainView{
    
    DGHomeViewController *home = [[DGHomeViewController alloc] init];
    DGBaoyouViewController *baoyou = [[DGBaoyouViewController alloc] init];
    DGSpecialViewController *special = [[DGSpecialViewController alloc] init];
    ALiTradeWebViewController *car = [[ALiTradeWebViewController alloc] init];
    DGMyViewController *me = [[DGMyViewController alloc] init];
    
    [self addChildViewItem:home title:@"优惠券" image:@"home_nor" selectImage:@"home_pre"];
    [self addChildViewItem:baoyou title:@"9.9包邮" image:@"zhangben_nor" selectImage:@"zhangben_pre"];
    [self addChildViewItem:special title:@"特惠" image:@"mine_nor" selectImage:@"mine_pre"];
   // [self addChildViewItem:car title:@"购物车" image:@"mine_nor" selectImage:@"mine_pre"];
   // [self addChildViewItem:me title:@"我的" image:@"mine_nor" selectImage:@"mine_pre"];
}

-(void) addChildViewItem:(UIViewController *)curItem title:(NSString *)title image:(NSString *)image selectImage:(NSString *) selectImage{
    curItem.tabBarItem.title=title;
    UIImage *imageV =[UIImage imageNamed:image];
    imageV= [imageV imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIImage *selectImageV =[UIImage imageNamed:selectImage];
    selectImageV= [selectImageV imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    curItem.tabBarItem.image=imageV;
    curItem.tabBarItem.selectedImage=selectImageV;
    WZNavigationController *nav=[[WZNavigationController alloc] initWithRootViewController:curItem];
    [self addChildViewController:nav];
    
}

@end
