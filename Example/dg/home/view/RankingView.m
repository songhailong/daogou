//
//  RankingView.m
//  dg_Example
//
//  Created by che on 2018/4/9.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "RankingView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DGDetailViewController.h"
#import "WZWebViewController.h"

@interface RankingView()
@property (nonatomic,strong) DGListModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;


@end

@implementation RankingView

-(void)awakeFromNib{
    [super awakeFromNib];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetail)];
    [self addGestureRecognizer:tap];
    
}

-(void)update:(DGListModel *)model{
    self.model=model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.prdtImgUrl] placeholderImage:nil];
    self.nameLabel.text=model.prdtName;
    self.priceLabel.text=[NSString stringWithFormat:@"¥%.1f",model.prdtPrice-model.couponValue];
    self.marketLabel.text=[NSString stringWithFormat:@"¥%.1f",model.prdtPrice];
}
-(void)showDetail{
//    UINavigationController *nav = [MSActiveControllerFinder finder].activeNavigationController();
//    DGDetailViewController *vc = [[DGDetailViewController alloc] initWidthId:self.model.couponClickUrl];
//    [nav pushViewController:vc animated:YES];
    
    UINavigationController *nav = [MSActiveControllerFinder finder].activeNavigationController();
    NSURL *url = [NSURL URLWithString:self.model.couponClickUrl];
    WZWebViewController *web = [[WZWebViewController alloc] initWithURL:url];
    [nav pushViewController:web animated:YES];
}

@end
