//
//  ALiTradeWantViewController.h
//  ALiSDKAPIDemo
//
//  Created by com.alibaba on 16/6/1.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALiTradeWebViewController : UIViewController<UIWebViewDelegate, NSURLConnectionDelegate>
@property (nonatomic, copy) NSString *openUrl;
@property (strong, nonatomic) UIWebView *webView;

@end


