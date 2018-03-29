//
//  DGHomeListTableViewCell.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGHomeListTableViewCell.h"
#import "DGListModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface DGHomeListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *des;


@end

@implementation DGHomeListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)update:(id<baseCellModelProtocal>)cellModel{
    
    DGListModel *model = (DGListModel *)cellModel;
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

@end
