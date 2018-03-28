//
//  carEmptry.m
//  dg_Example
//
//  Created by che on 2018/3/28.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "carEmptry.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "DGGlobalConfig.h"
@interface carEmptry()

@property(nonatomic, strong) loginSuccessCallback loginSuccessCallback;
@property(nonatomic, strong) loginFailureCallback loginFailedCallback;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
-(IBAction)LoginClick:(id)sender;
@end

@implementation carEmptry

-(void)awakeFromNib{
    [super awakeFromNib];
    self.loginButton.layer.cornerRadius=5;
    self.loginButton.clipsToBounds=YES;
}

-(IBAction)LoginClick:(id)sender{
    
    _loginSuccessCallback=^(ALBBSession *session){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCarNot" object:nil];
    };
    
    _loginFailedCallback=^(ALBBSession *session, NSError *error){
        [[MyAlertView alertViewWithTitle:@"登录失败" message:@"请稍后再试！" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    };
    //
    [[ALBBSDK sharedInstance] auth:nil successCallback:_loginSuccessCallback failureCallback:_loginFailedCallback];
}

@end
