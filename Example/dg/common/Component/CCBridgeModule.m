//
//  CCBridgeModule.m
//  che
//
//  Created by 万圣伟业 on 2017/8/25.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCBridgeModule.h"
#import <JLRoutes/JLRoutes.h>
#import <MSAppModuleWebApp/JSBridge.h>
#import <commonLib/MSActiveControllerFinder.h>
#import <commonLib/NSDictionary+JSONString.h>
#import <commonLib/MSCoreSDKAvailability.h>
#import <PINCache/PINCache.h>

@implementation CCBridgeModule

@synthesize bridge = _bridge;

JS_EXPORT_MODULE();

- (NSString *)moduleSourceFile {
    return [[NSBundle bundleForClass:[self class]] pathForResource:@"CCJSBridge" ofType:@"js"];
}

- (void)attachToJSBridge:(JSBridge *)bridge {
    
    [self onGetOs:bridge];
    [self onBack:bridge];
}


-(void)onGetOs:(JSBridge *)bridge{
    __weak typeof(self) weakSelf = self;
    [self registerHandler:@"onGetOs" handler:^(id data, WVJBResponseCallback responseCallback) {

        NSDictionary *param =@{@"type":@"IOS"};
        NSString *dictStringf = [param jsonString];
        NSString *javaScriptString = [NSString stringWithFormat:@"window._onGetOs(%@);",dictStringf];
        responseCallback(@{@"type":@"IOS"});
        
        [weakSelf.bridge.webView evaluateJavaScript:javaScriptString completionHandler:nil];
    }];
    
    
}

-(void)onBack:(JSBridge *)bridge{
//    __weak typeof(self) weakSelf = self;
    __weak UIViewController *viewController = bridge.viewController;
    [self registerHandler:@"onBack" handler:^(id data, WVJBResponseCallback responseCallback) {
        [viewController.navigationController popViewControllerAnimated:YES];
    }];
    
    
}


@end
