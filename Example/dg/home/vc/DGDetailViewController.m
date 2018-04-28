//
//  DGDetailViewController.m
//  dg_Example
//
//  Created by che on 2018/4/9.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGDetailViewController.h"
#import "DGGlobalConfig.h"
@interface DGDetailViewController ()

@property (nonatomic,strong) NSString *Id;

@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;
@end

@implementation DGDetailViewController

-(instancetype)initWidthId:(NSString *)Id{
    self=[self init];
    if (self) {
        self.Id=Id;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"商品详情";

    
    _onTradeSuccess=^(AlibcTradeResult *tradeProcessResult){
        NSLog(@"aa===%lu",(unsigned long)tradeProcessResult.result);
    };
    _onTradeFailure=^(NSError *error){
        NSLog(@"打开订单失败");
    };
    
}

- (void)openCar {
    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:[NSString stringWithFormat:@"%@",self.Id]];
    
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
