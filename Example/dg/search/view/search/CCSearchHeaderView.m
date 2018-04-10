//
//  CCSearchHeaderView.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/6.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCSearchHeaderView.h"
#import <commonLib/MSActiveControllerFinder.h>
#import "CCSearchTableViewController.h"
#import "DGSearchViewController.h"
#import <PINCache/PINCache.h>

@interface CCSearchHeaderView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchText;

@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)cancelClick:(id)sender;

@end

@implementation CCSearchHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
}

+(instancetype)initWithXib{
    CCSearchHeaderView *header = (CCSearchHeaderView *)[[NSBundle mainBundle] loadNibNamed:@"CCSearchHeaderView" owner:nil options:nil].firstObject;
    header.contentView.layer.cornerRadius=5;
    header.searchTextField.delegate=header;

    
    
//    [header.searchTextField becomeFirstResponder];
    
    return  header;
}



- (IBAction)cancelClick:(id)sender {
    
    NSString *key = self.searchText.text;
    if (key.length==0) {
        [MBProgressHUD showToast:@"请输入搜索关键字"];
        return;
    }
    MSActiveControllerFinder *finder =[MSActiveControllerFinder finder];
    UINavigationController *nav = finder.activeNavigationController();
    DGSearchViewController *vc =[[DGSearchViewController alloc] initWidthKey:key];
    [nav pushViewController:vc animated:YES];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *key = self.searchText.text;
    if (key.length==0) {
        [MBProgressHUD showToast:@"请输入搜索关键字"];
        return YES;
    }
    MSActiveControllerFinder *finder =[MSActiveControllerFinder finder];
    UINavigationController *nav = finder.activeNavigationController();
    
    [self saveHistory:@"history_car"];
    DGSearchViewController *vc =[[DGSearchViewController alloc] initWidthKey:textField.text];
    [nav pushViewController:vc animated:YES];
    return YES;
}

-(void)saveHistory:(NSString *)key{
    NSString *value = self.searchTextField.text;
    if (value.length==0) {
        return;
    }
    NSArray *array = [[PINCache sharedCache] objectForKey:key];
    if (array!=nil) {
        if (![array containsObject:value]) {
            NSMutableArray *mutablearray = [array mutableCopy];
            [mutablearray addObject:value];
            [[PINCache sharedCache] setObject:mutablearray forKey:key];
        }
    }else{
        NSArray *array = @[value];
        [[PINCache sharedCache] setObject:array forKey:key];
    }
}

-(void)didSelectedIndex:(NSInteger)index{
    if (self.block) {
        self.block(index);
    }
}

@end
