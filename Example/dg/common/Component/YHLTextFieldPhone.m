//
//  YHLTextFieldPhone.m
//  Pods
//
//  Created by 万圣伟业 on 2017/3/3.
//
//

#import "YHLTextFieldPhone.h"

@interface YHLTextFieldPhone ()
{
    int _inputType;
}
@property (nonatomic,strong) UITextRange *textRange;

@end

@implementation YHLTextFieldPhone

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setProperty];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setProperty];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setProperty];
    }
    return self;
}

-(void)setFormat:(BOOL)format{
    _format=format;
    if (format) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:self];
    }else{
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

-(void)dealloc{
    self.delegate=nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)setProperty{
    self.keyboardType=UIKeyboardTypeNumberPad;
    self.delegate=self;
}

-(void)textFieldChange:(NSNotification *)not{
    UITextField *textField = not.object;
    self.textRange = textField.selectedTextRange;
    int length = [[self.textRange valueForKeyPath:@"_start._offset"] intValue];
    
    NSString *oldStr = textField.text;
    oldStr = [oldStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (oldStr.length>7) {
        
        NSMutableString* mutableOldStr=[[NSMutableString alloc] initWithString:oldStr];
        [mutableOldStr insertString:@" " atIndex:3];
        [mutableOldStr insertString:@" " atIndex:8];
        textField.text=[mutableOldStr copy];
        
        if (_inputType==0) {
            if (length==9) {
                [self.textRange setValue:@(length+1).stringValue forKeyPath:@"_start._offset"];
                [self.textRange setValue:@(length+1).stringValue forKeyPath:@"_end._offset"];
            }
        }
        textField.selectedTextRange=self.textRange;
        
    }else if(oldStr.length>3){
        NSMutableString* mutableOldStr=[[NSMutableString alloc] initWithString:oldStr];
        [mutableOldStr insertString:@" " atIndex:3];
        textField.text=[mutableOldStr copy];
        if (length==4) {
            [self.textRange setValue:@(length+1).stringValue forKeyPath:@"_start._offset"];
            [self.textRange setValue:@(length+1).stringValue forKeyPath:@"_end._offset"];
        }
        textField.selectedTextRange=self.textRange;
    }

}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.cdelegate respondsToSelector:@selector(yhl_textField:shouldChangeCharactersInRange:replacementString:)]) {
        [self.cdelegate yhl_textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    if (self.isFormat) {
        //回车
        if (range.length>0) {
            _inputType=1;
        }else{
            _inputType=0;
        }
        
        if ([textField.text stringByAppendingString:string].length>13) {
            return NO;
        }
        if ((range.location-range.length)>12&&range.location>0) {
            return NO;
        }
        
        if (range.length==0&&[textField.text stringByAppendingString:string].length==13) {
            //NSLog(@"aa");
        }else{
            //NSLog(@"bb");
        }
    }else{
        if ([textField.text stringByAppendingString:string].length>11) {
            return NO;
        }
        if ((range.location-range.length)>11) {
            return NO;
        }
        
        if (range.length==0&&[textField.text stringByAppendingString:string].length==11) {
           // NSLog(@"aa");
        }else{
           // NSLog(@"bb");
        }

    }
        return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.cdelegate respondsToSelector:@selector(yhl_textFieldDidBeginEditing:)]) {
        [self.cdelegate yhl_textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.cdelegate respondsToSelector:@selector(yhl_textFieldDidEndEditing:)]) {
        [self.cdelegate yhl_textFieldDidEndEditing:textField];
    }
}

-(NSString *)yhl_text{
    NSString *string = [self.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    return string;
}


@end
