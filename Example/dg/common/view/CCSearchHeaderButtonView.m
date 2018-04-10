//
//  CCSearchHeaderButtonView.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/8.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCSearchHeaderButtonView.h"
#import <commonLib/MSActiveControllerFinder.h>
#import "CCSearchTableViewController.h"
#import "WZTabBarController.h"

@interface CCSearchHeaderButtonView()

@property (weak, nonatomic) IBOutlet UIButton *btn;
- (IBAction)btnClick:(id)sender;

@end

@implementation CCSearchHeaderButtonView

//+(instancetype) initWithXib:(CGRect)frame{
//    CCSearchHeaderButtonView *header  = [[NSBundle mainBundle] loadNibNamed:@"CCSearchHeaderButtonView" owner:nil options:nil].firstObject;
//    header.frame=frame;
//    header.layer.cornerRadius=5;
//    header.clipsToBounds=YES;
//    return header;
//}

-(void)setContentMode:(UIControlContentHorizontalAlignment)contentMode{
    self.btn.contentHorizontalAlignment=contentMode;
    [self.btn setImage:nil forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title{
    [self.btn setTitle:title forState:UIControlStateNormal];
    [self.btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
}


- (IBAction)btnClick:(id)sender {
    
    MSActiveControllerFinder *finder =[MSActiveControllerFinder finder];
    UITabBarController *tab = finder.activeTabBarController();
    [tab setSelectedIndex:1];
}
- (CGSize)intrinsicContentSize {
    return CGSizeMake(WZwidth-32, 34);
}
@end
