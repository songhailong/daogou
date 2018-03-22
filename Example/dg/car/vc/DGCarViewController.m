//
//  DGCarViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGCarViewController.h"
#import "DGGlobalConfig.h"

@interface DGCarViewController ()

@property (nonatomic,strong) ALiTradeWebViewController* childVC;

@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;

@end

@implementation DGCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"购物车";
    [self openCar];
}

- (void)openCar {

    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = [DGGlobalConfig openType];
    showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
    showParam.nativeFailMode=[DGGlobalConfig NativeFailMode];
    showParam.linkKey=[DGGlobalConfig schemeType];
    
//    ALiTradeWebViewController* vc = [[ALiTradeWebViewController alloc] init];
//    self.childVC=vc;
    NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:self webView:self.webView page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];
    if (res == 1) {
//        [self.navigationController pushViewController:vc animated:YES];
       
        self.webView.backgroundColor=[UIColor whiteColor];

    }
}

@end
