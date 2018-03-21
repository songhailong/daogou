//
//  WZEmptyView.m
//  12123_Example
//
//  Created by che on 2018/2/26.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZEmptyView.h"

@interface WZEmptyView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *linkButton;
- (IBAction)btnClick:(id)sender;


@end


@implementation WZEmptyView

-(void)update:(NSString *)image title:(NSString *)title link:(NSString *)link isShowLink:(BOOL)isShowLink{
    self.iconImageView.image = [UIImage imageNamed:image];
    self.titleLabel.text=title;
    self.linkButton.hidden=!isShowLink;
    [self.linkButton setTitle:link forState:UIControlStateNormal];
}

- (IBAction)btnClick:(id)sender {
    if (self.block) {
        self.block();
    }
}
@end
