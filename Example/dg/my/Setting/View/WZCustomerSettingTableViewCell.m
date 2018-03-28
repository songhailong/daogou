//
//  WZCustomerSettingTableViewCell.m
//  12123_Example
//
//  Created by che on 2018/1/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCustomerSettingTableViewCell.h"
#import "WZCustomerSettingItemCellModel.h"

@interface WZCustomerSettingTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *logoutLabel;

@end


@implementation WZCustomerSettingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)update:(id<baseCellModelProtocal>)cellModel{
    WZCustomerSettingItemCellModel *model = (WZCustomerSettingItemCellModel *)cellModel;
    
    self.titleLabel.text=model.title;
    self.subTitleLabel.text=model.subTitle;
    
    self.logoutLabel.hidden=!model.isLogout;
    self.titleLabel.hidden=model.isLogout;
    self.subTitleLabel.hidden=model.isLogout;
    self.rightImageView.hidden=model.isLogout;
    
}

@end
