//
//  YHLTextFieldPhone.h
//  Pods
//
//  Created by 万圣伟业 on 2017/3/3.
//
//

#import <UIKit/UIKit.h>

@protocol YHLTextFieldDelegate <NSObject>

@optional
- (void)yhl_textFieldDidBeginEditing:(UITextField *)textField;
- (void)yhl_textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)yhl_textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
@end

@interface YHLTextFieldPhone : UITextField<UITextFieldDelegate>
//是否启动手机格式化 344格式
@property (nonatomic,assign,getter=isFormat,setter=setFormat:) BOOL format;

@property (nonatomic, weak) id <YHLTextFieldDelegate> cdelegate;

@property (nonatomic,copy) NSString  *yhl_text;

@end
