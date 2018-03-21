//
//  SBRefreshNormalHeader.m
//  Pods
//
//  Created by 万圣伟业 on 2017/4/18.
//
//

#import "SBRefreshNormalHeader.h"
@interface SBRefreshNormalHeader()
{
}
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;
@end
@implementation SBRefreshNormalHeader

- (UIActivityIndicatorView *)loadingView
{
    if (!_loadingView) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
        loadingView.hidesWhenStopped = YES;
        //loadingView.color=[UIColor colorWithRed:0.99 green:0.76 blue:0.2 alpha:0.5];
        [self addSubview:_loadingView = loadingView];
    }
    return _loadingView;
}


@end
