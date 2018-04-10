//
//  CCHotSearchCollectionViewCell.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/5.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCHotSearchCollectionViewCell.h"
#import <commonLib/MSActiveControllerFinder.h>
#import "CCSearchTableViewController.h"
#import <commonLib/UIImage+Utility.h>
#import "DGSearchViewController.h"
@interface CCHotSearchCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;
- (IBAction)hotClick:(id)sender;

@end

@implementation CCHotSearchCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.hotBtn.layer.borderWidth=0.5;
    self.hotBtn.layer.borderColor=[UIColor colorWithHexString:@"8c8d99"].CGColor;
    self.hotBtn.layer.cornerRadius=5;
    self.hotBtn.clipsToBounds=YES;
    [self.hotBtn setBackgroundImage:[UIImage ms_imageWithColor:[UIColor colorWithHexString:@"ffffff"]] forState:UIControlStateNormal];
    [self.hotBtn setBackgroundImage:[UIImage ms_imageWithColor:[UIColor colorWithHexString:@"FA4F18"]] forState:UIControlStateHighlighted];
    
}

-(void)update:(NSString *)key{
    [self.hotBtn setTitle:key forState:UIControlStateNormal];
}
- (IBAction)hotClick:(id)sender {
    
    MSActiveControllerFinder *finder =[MSActiveControllerFinder finder];
    UINavigationController *nav = finder.activeNavigationController();
    DGSearchViewController *vc =[[DGSearchViewController alloc] initWidthKey:self.hotBtn.currentTitle];
    
    [nav pushViewController:vc animated:YES];
    
}
@end
