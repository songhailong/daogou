//
//  CCSearchHeaderButtonView.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/8.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCSearchHeaderButtonView.h"
#import <commonLib/MSActiveControllerFinder.h>
#import "DGSearchViewController.h"

@interface CCSearchHeaderButtonView()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnClick:(id)sender;

@end

@implementation CCSearchHeaderButtonView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.searchTextField.delegate=self;
    self.searchTextField.layer.cornerRadius=5;
    self.searchTextField.layer.borderWidth=0.5;
    self.searchTextField.layer.borderColor=[UIColor colorWithHexString:@"e6e6e6"].CGColor;
}

+(instancetype) initWithXib:(CGRect)frame{
    CCSearchHeaderButtonView *header  = [[NSBundle mainBundle] loadNibNamed:@"CCSearchHeaderButtonView" owner:nil options:nil].firstObject;
    header.frame=frame;
    header.layer.cornerRadius=5;
    header.clipsToBounds=YES;
    return header;
}

-(void)setContentMode:(UIControlContentHorizontalAlignment)contentMode{
    self.btn.contentHorizontalAlignment=contentMode;
    [self.btn setImage:nil forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    [self.btn setTitle:title forState:UIControlStateNormal];
    [self.btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
}


- (IBAction)btnClick:(id)sender {
    if (self.searchTextField.text.length==0) {
        [MBProgressHUD showError:@"请输入搜索关键字"];
        return;
    }
    MSActiveControllerFinder *finder =[MSActiveControllerFinder finder];
    UINavigationController *nav = finder.activeNavigationController();
    
    DGSearchViewController *vc = [[DGSearchViewController alloc] initWidthKey:self.searchTextField.text];
    [nav pushViewController:vc animated:YES];
    
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake(WZwidth, 34);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btnClick:nil];
    return YES;
}
@end
