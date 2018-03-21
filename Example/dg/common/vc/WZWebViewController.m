//
//  WZWebViewController.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZWebViewController.h"

@interface WZWebViewController (){
    BOOL _isShowTitle;
}
@property (strong,nonatomic) UIActivityIndicatorView *indicator;
@property (strong,nonatomic) UIView *progressView;
@end

@implementation WZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self craeteProgress];
  
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.frame=CGRectMake(self.view.center.x-20, self.view.center.y-100, 40, 40);
    indicator.color=[UIColor colorWithHexString:@"0F9FFF"];
    CGAffineTransform transform = CGAffineTransformMakeScale(.7f, .7f);
    indicator.transform = transform;
    [(UIActivityIndicatorView *)indicator startAnimating];
    self.indicator=indicator;
    [self.view addSubview:indicator];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(void)craeteProgress{
    UIView *progress = [[UIView alloc] initWithFrame:CGRectMake(0, 1, 0, 2)];
    progress.backgroundColor=[UIColor colorWithHexString:@"0F9FFF"];
    self.progressView=progress;
    [self.view addSubview:progress];
}

- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden=NO;
    self.progressView.alpha=1.0;
    _isShowTitle=YES;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    WKWebView *web = object;
    if ([web isKindOfClass:[WKWebView class]]) {
        double progress = web.estimatedProgress;
        self.progressView.frame=CGRectMake(0, 1, WZwidth*progress, 2);
        if (progress>0.8) {
            [self.indicator removeFromSuperview];
        }
        if (progress==1.00) {
            [UIView animateWithDuration:0.5 animations:^{
                self.progressView.alpha=0.0;
            } completion:^(BOOL finished) {
                self.progressView.hidden=YES;
            }];
        }
        if (_isShowTitle) {
            _isShowTitle=NO;
            [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable rs, NSError *_Nullable error) {
                if (rs!=nil) {
                    self.navigationItem.title=rs;
                }
            }];
        }
        
    }
}







@end
