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
    self.totalLabel.text=@(model.couponRemainCount).stringValue;
    self.priceLabel.text=[NSString stringWithFormat:@"%.2f",model.prdtPrice-model.couponValue];
    self.marketLabel.text=[NSString stringWithFormat:@"%.2f",model.prdtPrice];
    
}

@end
