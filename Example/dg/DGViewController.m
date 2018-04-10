//
//  DGViewController.m
//  dg
//
//  Created by 272789124@qq.com on 03/14/2018.
//  Copyright (c) 2018 272789124@qq.com. All rights reserved.
//

#import "DGViewController.h"
#import "DGGlobalConfig.h"


@interface DGViewController ()
@property(nonatomic, strong) loginSuccessCallback loginSuccessCallback;
@property(nonatomic, strong) loginFailureCallback loginFailedCallback;

- (IBAction)btnClick:(id)sender;

- (IBAction)openDetail:(id)sender;
- (IBAction)openCarClick:(id)sender;
@end

@implementation DGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _loginSuccessCallback=^(ALBBSession *session){
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[session getUser]];
        NSLog(@"%@", tip);
        [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };
    
    _loginFailedCallback=^(ALBBSession *session, NSError *error){
        NSString *tip=[NSString stringWithFormat:@"登录失败:%@",@""];
        NSLog(@"%@", tip);
        [[MyAlertView alertViewWithTitle:@"登录失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };
    
    _onTradeSuccess=^(AlibcTradeResult *tradeProcessResult){
        if(tradeProcessResult.result ==AlibcTradeResultTypePaySuccess){
            NSString *tip=[NSString stringWithFormat:@"交易成功:成功的订单%@\n，失败的订单%@\n",[tradeProcessResult payResult].paySuccessOrders,[tradeProcessResult payResult].payFailedOrders];
            [[MyAlertView alertViewWithTitle:@"交易成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }else if(tradeProcessResult.result==AlibcTradeResultTypeAddCard){
            [[MyAlertView alertViewWithTitle:@"加入购物车" message:@"加入成功" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    };
    _onTradeFailure=^(NSError *error){
        //        退出交易流程
        if (error.code==AlibcErrorCancelled) {
            return ;
        }
        NSDictionary *infor=[error userInfo];
        NSArray*  orderid=[infor objectForKey:@"orderIdList"];
        NSString *tip=[NSString stringWithFormat:@"交易失败:\n订单号\n%@",orderid];
        [[MyAlertView alertViewWithTitle:@"交易失败" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };
}

- (IBAction)btnClick:(id)sender {
    if(![[ALBBSession sharedInstance] isLogin]){
        [[ALBBSDK sharedInstance] auth:self successCallback:_loginSuccessCallback failureCallback:_loginFailedCallback];
    }else{
        ALBBSession *session=[ALBBSession sharedInstance];
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[[session getUser] ALBBUserDescription]];
        NSLog(@"%@", tip);
        [[MyAlertView alertViewWithTitle:@"登录成功" message:tip oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }
}

- (IBAction)openDetail:(id)sender {
    //44608674639
    //531249401478
    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:@"531249401478"];
    [self OpenByPage:page];
}

- (IBAction)openCarClick:(id)sender {
    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
    [self OpenByPage:page];
}

- (void)OpenByPage:(id<AlibcTradePage>)page
{
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = [DGGlobalConfig openType];
    //    showParam.backUrl=@"tbopen23082328:https://h5.m.taobao.com";
    
    showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
    BOOL isNeedPush=[ALiTradeSDKShareParam sharedInstance].isNeedPush;
    BOOL isBindWebview=[ALiTradeSDKShareParam sharedInstance].isBindWebview;
    showParam.isNeedPush=isNeedPush;
    showParam.nativeFailMode=[DGGlobalConfig NativeFailMode];
    
    //    showParam.linkKey = @"tmall_scheme";//暂时拉起天猫
    showParam.linkKey=[DGGlobalConfig schemeType];
    //    showParam.linkKey = @"dingding_scheme";//暂时拉起天猫
    
    if (isBindWebview) {
        
        ALiTradeWebViewController* view = [[ALiTradeWebViewController alloc] init];
        NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:view webView:view.webView page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];
        if (res == 1) {
            [self.navigationController pushViewController:view animated:YES];
        }
    } else {
        if (isNeedPush) {
            [[AlibcTradeSDK sharedInstance].tradeService show:self.navigationController page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback: self.onTradeFailure];
        } else {
            [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback: self.onTradeFailure];
        }
        
    }
}


- (void)OpenByPage2:(id<AlibcTradePage>)page
{
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = [DGGlobalConfig openType];
    //    showParam.backUrl=@"tbopen23082328:https://h5.m.taobao.com";
    
    showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
    BOOL isNeedPush=[ALiTradeSDKShareParam sharedInstance].isNeedPush;
    BOOL isBindWebview=[ALiTradeSDKShareParam sharedInstance].isBindWebview;
    showParam.isNeedPush=isNeedPush;
    showParam.nativeFailMode=[DGGlobalConfig NativeFailMode];
    
    //    showParam.linkKey = @"tmall_scheme";//暂时拉起天猫
    showParam.linkKey=[DGGlobalConfig schemeType];
    //    showParam.linkKey = @"dingding_scheme";//暂时拉起天猫
    
    if (!isBindWebview) {
        
        ALiTradeWebViewController* view = [[ALiTradeWebViewController alloc] init];
        NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:view webView:view.webView page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];
        if (res == 1) {
            [self.navigationController pushViewController:view animated:YES];
        }
    } else {
        if (!isNeedPush) {
            [[AlibcTradeSDK sharedInstance].tradeService show:self.navigationController page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback: self.onTradeFailure];
        } else {
            [[AlibcTradeSDK sharedInstance].tradeService show:self page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback: self.onTradeFailure];
        }
        
    }
}



@end
