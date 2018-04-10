//
//  CCSearchItemTableViewCell.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/6.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCSearchItemTableViewCell.h"
#import "CCCCHotSearchCellModel.h"
@interface CCSearchItemTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CCSearchItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)update:(id<baseCellModelProtocal>)cellModel{
    CCSearchItemCellModel *model =(CCSearchItemCellModel *)cellModel;
    
    self.titleLabel.text=model.searchKey;
}

@end
