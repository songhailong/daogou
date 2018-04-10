//
//  CCHistorySearchHeaderView.m
//  che_Example
//
//  Created by 杨红磊 on 2017/12/6.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCHistorySearchHeaderView.h"
#import <commonLib/YHLAlert.h>
@interface CCHistorySearchHeaderView ()
- (IBAction)deleteClick:(id)sender;

@end

@implementation CCHistorySearchHeaderView

+(instancetype)initWithXib{
    CCHistorySearchHeaderView *header =[[NSBundle mainBundle] loadNibNamed:@"CCHistorySearchHeaderView" owner:nil options:nil].firstObject;
    return  header;
}
- (IBAction)deleteClick:(id)sender {
    
    [YHLAlert showAlertinitWithTitle:@"提示" contentText:@"历史记录删除后不可恢复，确定要删除吗？" leftButtonTitle:@"确定" leftBlock:^{
        if (self.block) {
            self.block();
        }
    } rightButtonTitle:@"再想想" rightBlock:^{
        
    }];
    
}
@end
