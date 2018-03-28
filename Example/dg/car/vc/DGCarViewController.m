//
//  DGCarViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGCarViewController.h"
#import "DGGlobalConfig.h"
#import "carEmptry.h"
#import "UIView+WZXibView.h"
#import <Masonry/Masonry.h>
@interface DGCarViewController ()

@property (nonatomic,strong) carEmptry *empty;

@property (nonatomic,strong) ALiTradeWebViewController* childVC;

@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;

@end

@implementation DGCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"购物车";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(headerRefresh) name:@"refreshCarNot" object:nil];
    
    _onTradeSuccess=^(AlibcTradeResult *tradeProcessResult){
    };
    _onTradeFailure=^(NSError *error){
    };
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (self.empty!=nil) {
        [self headerRefresh];
    }
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)headerRefresh{
    [self.empty removeFromSuperview];
    self.empty=nil;
    
    [self openCar];
}

- (void)openCar {
    if(![[ALBBSession sharedInstance] isLogin]){
        carEmptry *empty = [carEmptry initWithXib];
        self.empty=empty;
        [self.view addSubview:empty];
        
        [empty mas_makeConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            } else {
                make.top.equalTo(self.view.mas_top);
            }
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            } else {
                make.bottom.equalTo(self.view.mas_bottom);
            }
            make.left.right.equalTo(self.view);
        }];
        
    }else{
        id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
        
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
}

@end
