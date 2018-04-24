//
//  DGProductListCollectionViewCell.m
//  dg_Example
//
//  Created by che on 2018/4/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGProductListCollectionViewCell.h"
#import "DGProductListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DGProductListCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *des;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;


@end

@implementation DGProductListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)update:(WZCollectionViewModel *)data{
    DGProductListModel *model  = (DGProductListModel *)data;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.prdtImgUrl] placeholderImage:nil];
    self.titleLabel.text=model.prdtName;
//    self.des.text=model.couponInfo;
    self.totalLabel.text=[NSString stringWithFormat:@"剩%ld件",model.couponRemainCount];
    NSInteger day = labs(model.couponLessHours)/24;
    NSInteger hours = labs(model.couponLessHours)%24;
    if (day>0) {
        self.timeLabel.text=[NSString stringWithFormat:@"剩%ld天%ld小时",(long)day,(long)hours];
    }else{
        self.timeLabel.text=[NSString stringWithFormat:@"剩%ld小时",(long)hours];
    }
    
//    if (model.couponRemainCount<=0||model.couponLessHours<=0) {
//        [self.buyButton setEnabled:NO];
//    }else{
//        [self.buyButton setEnabled:YES];
//    }
    
    self.priceLabel.text=[NSString stringWithFormat:@"¥%.2f",model.prdtPrice-model.couponValue];
    self.marketLabel.text=[NSString stringWithFormat:@"¥%.2f",model.prdtPrice];
    
}
@end
