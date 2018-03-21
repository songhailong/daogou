//
//  YHLTableEmptyView.h
//  Pods
//
//  Created by yanghonglei on 16/7/12.
//
//
#import <UIKit/UIKit.h>

/**
 *  空的View
 */
@interface YHLTableEmptyView : UIControl

@property (nonatomic, strong) UILabel *textlabel;
@property (nonatomic, strong) UIImageView *iconImageView;


- (instancetype)initWithFrame:(CGRect)frame;

@end
