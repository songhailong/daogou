//
//  DGTopCellView.m
//  dg_Example
//
//  Created by che on 2018/4/9.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGTopCellView.h"
#import "WZWebViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DGDetailViewController.h"

@interface DGTopCellView()

@property (nonatomic,strong) DGListModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIView *contentView;

- (IBAction)btnClick:(id)sender;

@end


@implementation DGTopCellView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetail)];
    [self.contentView addGestureRecognizer:tap];
}

-(void)update:(DGListModel *)model{
    self.model=model;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.prdtImgUrl] placeholderImage:nil];
    self.titleLabel.text=model.prdtName;
    self.des.text=model.couponInfo;
    self.totalLabel.text=[NSString stringWithFormat:@"剩%ld件",model.couponRemainCount];
    NSInteger day = labs(model.couponLessHours)/24;
    NSInteger hours = labs(model.couponLessHours)%24;
    if (day>0) {
        self.timeLabel.text=[NSString stringWithFormat:@"剩余%ld天%ld小时",(long)day,(long)hours];
    }else{
        self.timeLabel.text=[NSString stringWithFormat:@"剩余%ld小时",(long)hours];
    }
    
    self.priceLabel.text=[NSString stringWithFormat:@"%.1f",model.prdtPrice-model.couponValue];
    self.marketLabel.text=[NSString stringWithFormat:@"%.1f",model.prdtPrice];
    
}

-(void)showDetail{
    UINavigationController *nav = [MSActiveControllerFinder finder].activeNavigationController();
    DGDetailViewController *vc = [[DGDetailViewController alloc] initWidthId:self.model.prdtId];
    [nav pushViewController:vc animated:YES];
}

- (IBAction)btnClick:(id)sender {
    UINavigationController *nav = [MSActiveControllerFinder finder].activeNavigationController();
    NSURL *url = [NSURL URLWithString:self.model.couponClickUrl];
//    WZWebViewController *web = [[WZWebViewController alloc] initWithURL:url];
    DGProductDetailViewController *web = [[DGProductDetailViewController alloc] initWithId:self.model.prdtId];
    [nav pushViewController:web animated:YES];
}
@end
