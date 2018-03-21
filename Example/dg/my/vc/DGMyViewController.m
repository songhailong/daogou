//
//  DGMyViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGMyViewController.h"
#import "DGViewController.h"
@interface DGMyViewController ()
- (IBAction)btnClick:(id)sender;

@end

@implementation DGMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)btnClick:(id)sender {
    
    UIStoryboard *store = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    DGViewController *vc = [store instantiateViewControllerWithIdentifier:@"DGViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
@end
