//
//  DGSpecialViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGSpecialViewController.h"
#import "DGSpecialListViewController.h"
#import "CCSearchHeaderButtonView.h"
#import "UIView+WZXibView.h"
@interface DGSpecialViewController ()

@end

@implementation DGSpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.titleView=[CCSearchHeaderButtonView initWithXibWithFrame:CGRectMake(0, 5, WZwidth, 34)];
//    self.view.backgroundColor=[UIColor redColor];
    
    [self loadMenus];
}
static NSArray *array ;
- (void)loadMenus
{
    
    
    array = @[ @{@"cat":@"c1",@"title":@"女装"},
               @{@"cat":@"c2",@"title":@"美妆"},
               @{@"cat":@"c3",@"title":@"鞋包"},
               @{@"cat":@"c4",@"title":@"内衣"},
               @{@"cat":@"c5",@"title":@"男装"},
               @{@"cat":@"c6",@"title":@"配饰"},
               @{@"cat":@"c7",@"title":@"运动户外"},
               @{@"cat":@"c8",@"title":@"母婴"},
               @{@"cat":@"c9",@"title":@"食品"},
               @{@"cat":@"c10",@"title":@"数码"},
               @{@"cat":@"c11",@"title":@"家居"}
               ];
    
    NSMutableArray *vcs = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        DGSpecialListViewController *vc = [[DGSpecialListViewController alloc] initWithParam:dict];
        [vcs addObject:vc];
    }
    self.viewControllers = vcs;
}

@end
