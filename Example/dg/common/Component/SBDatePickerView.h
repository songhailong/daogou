//
//  SBDatePickerView.h
//  SBChe
//
//  Created by 万圣伟业 on 2017/3/9.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SBDatePickerView;
typedef void (^SBDatePickerMainViewBlock)();

@protocol SBDatePickerViewDelegate <NSObject>
@optional
- (void)currentDate :(NSString *)date;
- (void)currentDateTime :(NSDate *)date;
- (void)currentDateTime :(SBDatePickerView *)pickerView  date:(NSDate *)date;
- (void)currentDate :(NSString *)date indexPath:(NSIndexPath *)indexPath;
- (void)currentDateTime :(NSDate *)date indexPath:(NSIndexPath *)indexPath;
@end

@interface SBDatePickerView : UIView

@property(nonatomic,assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;


@property (nonatomic, weak) id <SBDatePickerViewDelegate> delegate;

@property (nonatomic,strong) NSIndexPath *indexPath;

-(void)showDatePickerView:(UIWindow *)window;
@end

@interface SBDatePickerMainView : UIView

@property(nonatomic,copy) SBDatePickerMainViewBlock block;

@end
