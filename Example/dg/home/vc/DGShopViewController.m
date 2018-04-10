//
//  DGShopViewController.m
//  dg_Example
//
//  Created by che on 2018/4/9.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGShopViewController.h"
#import "DGGlobalConfig.h"
@interface DGShopViewController ()

@property (nonatomic,strong) NSString *ShopId;

@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;
@end

@implementation DGShopViewController


-(instancetype)initWidthShopId:(NSString *)ShopId{
    self=[self init];
    if (self) {
        self.ShopId=ShopId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
//    self.navigationItem.title=@"";
    
    
    _onTradeSuccess=^(AlibcTradeResult *tradeProcessResult){
        NSLog(@"aa===%lu",(unsigned long)tradeProcessResult.result);
    };
    _onTradeFailure=^(NSError *error){
        NSLog(@"打开订单失败");
    };
    
}

- (void)openCar {
    id<AlibcTradePage> page = [AlibcTradePageFactory shopPage:[NSString stringWithFormat:@"%@",self.ShopId]];
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = [DGGlobalConfig openType];
    showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
    showParam.nativeFailMode=[DGGlobalConfig NativeFailMode];
    showParam.linkKey=[DGGlobalConfig schemeType];
    NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:self webView:self.webView page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];
    if (res == 1) {
        self.webView.backgroundColor=[UIColor whiteColor];
    }
}

@end
