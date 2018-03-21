//
//  WZViewController.m
//  TVSearch_Example
//
//  Created by che on 2018/1/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZViewController.h"

@interface WZViewController ()

@end

@implementation WZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
}



@end
