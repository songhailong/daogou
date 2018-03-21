//
//  MSActiveControllerFinder.m
//  EMStock
//
//  Created by ryan on 3/10/16.
//  Copyright © 2016 flora. All rights reserved.
//

#import "MSActiveControllerFinder.h"

static MSActiveControllerFinder *finder = nil;

@implementation MSActiveControllerFinder
/*
 ** 如果不想使用MSActiveControllerFinder默认的方法
 ** 可以自定义一个实现了MSActiveControllerFinder协议的类 通过此方法重置 finder
 *
 */
+ (void)setFinder:(id<MSActiveControllerFinder>)aFinder {
    finder = aFinder;
}

+ (instancetype)finder {
    if (finder) {
        return finder;
    }
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        finder = [[self alloc] init];
    });
    return finder;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUpDefaultRootTabBarController];
        [self setUpDefaultActiveTabBarController];
        [self setUpDefaultActiveNavigationController];
        [self setUpDefaultActiveTopViewController];
        [self setUpDefaultResetStatus];
    }
    return self;
}

- (void)setUpDefaultRootTabBarController {
    __weak __typeof(self)weakSelf = self;
    self.rootTabBarController = ^ UITabBarController * {
        return [weakSelf defaultActiveTabBarController];
    };
}

- (void)setUpDefaultActiveTabBarController {
    __weak __typeof(self)weakSelf = self;
    self.activeTabBarController = ^ UITabBarController * {
        return [weakSelf defaultActiveTabBarController];
    };
}

- (void)setUpDefaultActiveNavigationController {
    __weak __typeof(self)weakSelf = self;
    self.activeNavigationController = ^ UINavigationController *{
        return [weakSelf defaultActiveNavigationController];
    };
}

- (void)setUpDefaultActiveTopViewController {
    __weak __typeof(self)weakSelf = self;
    self.activeTopController = ^UIViewController * {
        return [weakSelf defaultActiveTopController];
    };
}

- (void)setUpDefaultResetStatus {
    self.resetStatus = ^{
    };
 }

- (UITabBarController *)defaultActiveTabBarController {
    UITabBarController *tabBarController = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([tabBarController isKindOfClass:[UITabBarController class]]) {
        return tabBarController;
    }
    return nil;
}

- (UINavigationController *)defaultActiveNavigationController {
    UITabBarController *tabBarController = [self defaultActiveTabBarController];
    if ([tabBarController isKindOfClass:[UITabBarController class]]) {
        UINavigationController *navigationController = [tabBarController selectedViewController];
        if ([navigationController isKindOfClass:[UINavigationController class]]) {
            if (navigationController.visibleViewController.navigationController==navigationController) {
                return navigationController;
            }else{
                if ([navigationController.visibleViewController.navigationController isKindOfClass:[UINavigationController class]]) {
                    return navigationController.visibleViewController.navigationController;
                }else{
                    return nil;
                }
            }
        }
        return nil;
    }
    
    UINavigationController *navigationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        if (navigationController.visibleViewController.navigationController==navigationController) {
            return navigationController;
        }else{
            if ([navigationController.visibleViewController.navigationController isKindOfClass:[UINavigationController class]]) {
                return navigationController.visibleViewController.navigationController;
            }else{
                return nil;
            }
        }
    }    
    return nil;
}

- (UIViewController *)defaultActiveTopController {
    return [[self defaultActiveNavigationController] topViewController];
}


@end
