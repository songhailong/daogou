//
//  baseCellModel.m
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import "baseCellModel.h"

@implementation baseCellModel

@synthesize Class;
@synthesize reuseIdentify;
@synthesize cacheHeight;
@synthesize isRegisterByClass;

- (instancetype)init {
    if (self = [super init]) {
        self.Class             = [UITableViewCell class];
        self.reuseIdentify     = @"UITableViewCell";
        self.isRegisterByClass = YES;
    }
    return self;
}
@end
