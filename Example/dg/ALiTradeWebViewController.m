//
//  ALiTradeWantViewController.m
//  ALiSDKAPIDemo
//
//  Created by com.alibaba on 16/6/1.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import "ALiTradeWebViewController.h"
//#import "ALiWebViewService.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "DGGlobalConfig.h"
//#import "ALiCartService.h"

@interface ALiTradeWebViewController()

@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;


@end

@implementation ALiTradeWebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.title=@"购物车";
//    self.fd_prefersNavigationBarHidden=YES;
    _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _webView.scrollView.scrollEnabled = YES;
    _webView.delegate = self;
    
    self.webView.backgroundColor=[UIColor colorWithHexString:@"EDEDED"];
    [self.view addSubview:_webView];
    
    [self openCar];
}
-(void)dealloc
{
    _webView =  nil;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
        
    return YES;
}

- (void)openCar {
    
//    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
//    
//    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
//    showParam.openType = [DGGlobalConfig openType];
//    showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
//    showParam.nativeFailMode=[DGGlobalConfig NativeFailMode];
//    showParam.linkKey=[DGGlobalConfig schemeType];
//    
//    //    ALiTradeWebViewController* vc = [[ALiTradeWebViewController alloc] init];
//    //    self.childVC=vc;
//    NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:self webView:self.webView page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];
//    if (res == 1) {
//        //        [self.navigationController pushViewController:vc animated:YES];
//        
////        self.webView.backgroundColor=[UIColor whiteColor];
//        
//    }
}


@end
