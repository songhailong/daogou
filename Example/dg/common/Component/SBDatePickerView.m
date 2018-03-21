//
//  SBDatePickerView.m
//  SBChe
//
//  Created by 万圣伟业 on 2017/3/9.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "SBDatePickerView.h"
#define SBwidth [[UIScreen mainScreen] bounds].size.width
#define SBheight [[UIScreen mainScreen] bounds].size.height
@interface SBDatePickerView ()
@property (nonatomic,strong) UIView *maskView;//蒙版
@property (nonatomic,strong) SBDatePickerMainView *mainView;//底部弹出面板
@property (nonatomic, strong) UIDatePicker *pickerView;//
@property (nonatomic, strong) UIButton *customButton;//确认按钮
@property (nonatomic, strong) UIButton *cancleButton;//取消按钮
@end

@implementation SBDatePickerView


-(instancetype)init{
    self=[super init];
    if (self) {
        
    }
    return self;
}

- (UIView *)maskView{
    if (_maskView==nil) {
        _maskView=[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor=[UIColor blackColor];
        _maskView.alpha=0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMaskView)];
        [_maskView addGestureRecognizer:tap];
        
    }
    return _maskView;
}

- (SBDatePickerMainView *)mainView{
    if (_mainView==nil) {
        _mainView=[[SBDatePickerMainView alloc] initWithFrame:CGRectMake(0, SBheight, SBwidth, 252)];
        _mainView.backgroundColor=[UIColor whiteColor];
        _mainView.block=^(){
            UIView *v =self;//这里不做任何事。仅仅为了 保留self 不被销毁
        };
        [_mainView addSubview:self.customButton];
        [_mainView addSubview:self.cancleButton];
        
        UIView *line =[[UIView alloc] initWithFrame:CGRectMake(0, 43, SBwidth, 1)];
        line.backgroundColor=[UIColor colorWithHexString:@"e6e6e6"];
        [_mainView addSubview:line];
        [_mainView addSubview:self.pickerView];
    }
    return _mainView;
}

- (UIButton *)customButton{
    if (!_customButton) {
        _customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _customButton.frame = CGRectMake(SBwidth - 100, 0, 100, 42);
        [_customButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 35, 0, 0)];
        [_customButton setTitleColor:[UIColor colorWithHexString:@"0F9FFF"] forState:UIControlStateNormal];
        [_customButton setTitle:@"确认" forState:UIControlStateNormal];
        [_customButton addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customButton;
}

- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, 0, 100, 42);
        [_cancleButton setTitleColor:[UIColor colorWithHexString:@"0F9FFF"] forState:UIControlStateNormal];
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 35)];
        
        [_cancleButton addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UIDatePicker *)pickerView{
    if (!_pickerView) {
       _pickerView =[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 42, SBwidth, 210)];
        _pickerView.datePickerMode=self.datePickerMode;
        if (self.maximumDate) {
            _pickerView.maximumDate=self.maximumDate;
        }
        if (self.minimumDate) {
            _pickerView.minimumDate =self.minimumDate;
        }
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        _pickerView.locale = locale;
    }
    return _pickerView;
}


-(void)showDatePickerView:(UIWindow *)window{
    [window addSubview:self.maskView];
    [window addSubview:self.mainView];
    [UIView animateWithDuration:0.4 animations:^{
        self.mainView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - 252, [[UIScreen mainScreen] bounds].size.width, 252);
    }];

}
-(void)removeMaskView{
    if (_maskView!=nil) {
        [_maskView removeFromSuperview];
    }
    if (_mainView!=nil) {
        [UIView animateWithDuration:0.4 animations:^{
            _mainView.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, 252);
        } completion:^(BOOL finished) {
            [_mainView removeFromSuperview];
            _mainView.block=nil;//一定要置空 否则无法销毁
        }];
    }
   
}

-(void)commitClick{
    
    NSDateFormatter *formattor = [[NSDateFormatter alloc] init];
    formattor.dateFormat = @"yyyy-MM-dd";
    NSString *timestamp = [formattor stringFromDate:self.pickerView.date];
    if ([self.delegate respondsToSelector:@selector(currentDate:)]) {
        [self.delegate currentDate:timestamp];
    }
    if ([self.delegate respondsToSelector:@selector(currentDateTime:)]) {
        [self.delegate currentDateTime:self.pickerView.date];
    }
    if ([self.delegate respondsToSelector:@selector(currentDate:indexPath:)] ) {
        [self.delegate currentDate:timestamp indexPath:self.indexPath];
    }
    if ([self.delegate respondsToSelector:@selector(currentDateTime:indexPath:)] ) {
        [self.delegate currentDateTime:self.pickerView.date indexPath:self.indexPath];
    }
    if ([self.delegate respondsToSelector:@selector(currentDateTime:date:)]) {
        [self.delegate currentDateTime:self date:self.pickerView.date];
    }
    [self removeMaskView];
    
}
-(void)cancleClick{
    [self removeMaskView];
}

-(void)dealloc{
    NSLog(@"aa");
}

@end


@implementation SBDatePickerMainView


@end
