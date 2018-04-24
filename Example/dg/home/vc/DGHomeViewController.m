//
//  DGHomeViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGHomeViewController.h"
#import "DGViewController.h"
#import "DGListViewController.h"
#import "CCSearchHeaderButtonView.h"
#import "UIView+WZXibView.h"
#import "DGMainViewController.h"

@interface DGHomeViewController ()

@end

@implementation DGHomeViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self loadMenus];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        [self loadMenus];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor=[UIColor redColor];
    self.navigationItem.title=@"分类";
    
//    CCSearchHeaderButtonView *headerView = [CCSearchHeaderButtonView initWithXibWithFrame:CGRectMake(0, 5, WZwidth, 34)];
//    headerView.layer.cornerRadius=5;
//    headerView.clipsToBounds=YES;
//    self.navigationItem.titleView=headerView;
    
//    [self.navigationView setValue:[[NSNumber alloc] initWithInt:1] forKeyPath:@"aligment"];
    self.navigationView.selectedTextColor = [UIColor colorWithHexString:@"FA4F18"];
    self.navigationView.normalTextColor = [UIColor colorWithHexString:@"333333"];
//    self.navigationView.backgroundColor = [UIColor whiteColor];
//    self.navigationView.itemFont=[UIFont systemFontOfSize:14];
    self.navigationView.borderColor=[UIColor colorWithHexString:@"e6e6e6"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.selectedIndex=0;
    
}

static NSArray *array ;
- (void)loadMenus
{
    
    // @{@"cat":@"",@"title":@"全部"},
    array = @[
               @{@"cat":@"c1",@"title":@"女装"},
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
    
//    DGMainViewController *home = [[DGMainViewController alloc] init];
//    home.title=@"优选";
//    [vcs addObject:home];
    
    for (NSDictionary *dict in array) {
        DGListViewController *vc = [[DGListViewController alloc] initWithParam:dict];
        [vcs addObject:vc];
    }
    self.viewControllers = vcs;
}
@end
