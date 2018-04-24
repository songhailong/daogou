//
//  DGFeedbackViewController.m
//  dg_Example
//
//  Created by che on 2018/4/19.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGFeedbackViewController.h"

@interface DGFeedbackViewController ()
@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UITextField *telView;
@property (weak, nonatomic) IBOutlet UITextField *qqView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitClick:(id)sender;

@end

@implementation DGFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"意见反馈";
    self.submitButton.layer.cornerRadius=5;
    self.txtView.layer.cornerRadius=5;
    self.txtView.layer.borderColor=[UIColor colorWithHexString:@"e6e6e6"].CGColor;
    self.txtView.layer.borderWidth=0.5;
    
    self.telView.layer.cornerRadius=5;
    self.telView.layer.borderColor=[UIColor colorWithHexString:@"e6e6e6"].CGColor;
    self.telView.layer.borderWidth=0.5;
    
    self.qqView.layer.cornerRadius=5;
    self.qqView.layer.borderColor=[UIColor colorWithHexString:@"e6e6e6"].CGColor;
    self.qqView.layer.borderWidth=0.5;
}

- (IBAction)submitClick:(id)sender {
    
    NSString *content = self.txtView.text;
    NSString *tel = self.telView.text;
    NSString *qq = self.qqView.text;
    
    if (content.length<5) {
        [MBProgressHUD showDelayError:@"您的留言太少!"];
        return;
    }
    
    [MBProgressHUD showDelaySuccess:@"感谢您的反馈！我们会继续努力。"];
    
}
@end
