//
//  CCHistorySearchTableViewCell.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/6.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCHistorySearchTableViewCell.h"
#import "CCCCHotSearchCellModel.h"

@interface CCHistorySearchTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *historyLabel;

@end

@implementation CCHistorySearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)update:(id<baseCellModelProtocal>)cellModel{
    CCHistorySearchCellModel *model =(CCHistorySearchCellModel *)cellModel;
    self.historyLabel.text=model.historyKey;
}
@end
