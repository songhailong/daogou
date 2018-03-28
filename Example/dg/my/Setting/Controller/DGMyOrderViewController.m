//
//  DGMyOrderViewController.m
//  dg_Example
//
//  Created by che on 2018/3/28.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGMyOrderViewController.h"
#import "DGGlobalConfig.h"
@interface DGMyOrderViewController ()
@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;

@end

@implementation DGMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"我的订单";
//    [self openCar];
    
    _onTradeSuccess=^(AlibcTradeResult *tradeProcessResult){
        NSLog(@"aa===%lu",(unsigned long)tradeProcessResult.result);
        //        if(tradeProcessResult.result ==AlibcTradeResultTypePaySuccess){
        //            NSString *tip=[NSString stringWithFormat:@"交易成功:成功的订单%@\n，失败的订单%@\n",[tradeProcessResult payResult].paySuccessOrders,[tradeProcessResult payResult].payFailedOrders];
        //            [[MyAlertView alertViewWithTitle:@"交易成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        //        }else if(tradeProcessResult.result==AlibcTradeResultTypeAddCard){
        //            [[MyAlertView alertViewWithTitle:@"加入购物车" message:@"加入成功" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        //        }
    };
    _onTradeFailure=^(NSError *error){
        NSLog(@"打开订单失败");
        //        退出交易流程
        //        if (error.code==AlibcErrorCancelled) {
        //            return ;
        //        }
        //        NSDictionary *infor=[error userInfo];
        //        NSArray*  orderid=[infor objectForKey:@"orderIdList"];
        //        NSString *tip=[NSString stringWithFormat:@"交易失败:\n订单号\n%@",orderid];
        //        [[MyAlertView alertViewWithTitle:@"交易失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };
    
}

- (void)openCar {
    
    id<AlibcTradePage> page = [AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
    
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
