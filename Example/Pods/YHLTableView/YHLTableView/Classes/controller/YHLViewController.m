//
//  baseViewController.m
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import "YHLViewController.h"

@interface YHLViewController ()

@end

@implementation YHLViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars = NO;
        }
    }
    return self;
}

@end
