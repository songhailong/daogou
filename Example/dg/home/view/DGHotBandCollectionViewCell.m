//
//  DGHotBandCollectionViewCell.m
//  dg_Example
//
//  Created by che on 2018/4/8.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGHotBandCollectionViewCell.h"
#import "DGHotBandCellModel.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DGHotBandCollectionViewCell()
//@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation DGHotBandCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)update:(WZCollectionViewModel *)data{
    DGHotBandCellModel *model  = (DGHotBandCellModel *)data;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:nil];
    self.desLabel.text=model.brandSubscript;
    self.nameLabel.text=model.brandName;
    
}
@end
