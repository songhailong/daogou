//
//  DGMyViewController.m
//  dg_Example
//
//  Created by che on 2018/3/21.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGMyViewController.h"
#import "DGViewController.h"
#import <FDFullscreenPopGesture/UINavigationController+FDFullscreenPopGesture.h>
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "DGGlobalConfig.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "WZCustomerSettingViewController.h"
#import "DGMyOrderViewController.h"
#import <commonLib/YHLAlert.h>
#import "NSString+Hash.h"
#import <PINCache/PINCache.h>
#import "WZModule.h"
#import <commonLib/UIImage+Utility.h>
#import <commonLib/UIColor+HexString.h>
#import <commonLib/UIImage+FontAwesome.h>
#import "NSString+WZString.h"
#import "DGCarViewController.h"
#import "DGFeedbackViewController.h"
#import "DGMyCollectionViewController.h"
@interface DGMyViewController ()

@property(nonatomic, strong) loginSuccessCallback loginSuccessCallback;
@property(nonatomic, strong) loginFailureCallback loginFailedCallback;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *carButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
@property (weak, nonatomic) IBOutlet UIButton *fkButton;

- (IBAction)loginClick:(id)sender;
- (IBAction)myorderClick:(id)sender;
- (IBAction)settingClick:(id)sender;
- (IBAction)carClick:(id)sender;
- (IBAction)colClick:(id)sender;
- (IBAction)fkClick:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *codeText;
- (IBAction)submitClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *settingButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollV;

@property (weak, nonatomic) IBOutlet UIButton *myorderButton;
@end

@implementation DGMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_prefersNavigationBarHidden=YES;
    if (@available(iOS 11.0, *)) {
        [self.scrollV setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    self.headImage.layer.cornerRadius=30;
    self.headImage.clipsToBounds=YES;
    
    self.submitButton.layer.cornerRadius=5;
    
    __weak typeof(self) weakSelf = self;
    _loginSuccessCallback=^(ALBBSession *session){
        [weakSelf setupUI];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCarNot" object:nil];
    };
    
    _loginFailedCallback=^(ALBBSession *session, NSError *error){
        NSString *errorString = error.userInfo[@"NSLocalizedDescription"];
        if (![errorString containsString:@"H5_LOGIN_CANCEL"]) {
            [[MyAlertView alertViewWithTitle:@"登录失败" message:@"请稍后再试！" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        }
    };
    
    self.headImage.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(login)];
    [self.headImage addGestureRecognizer:tap];
 
    
    [self resetButton:self.carButton icon:@"icon-shopping-cart"];
    [self resetButton:self.myorderButton icon:@"icon-reorder"];
    [self resetButton:self.collectionButton icon:@"icon-star"];
    [self resetButton:self.fkButton icon:@"em-icon-help"];
    [self resetButton:self.settingButton icon:@"em-icon-tools"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupUI];
}

-(void)resetButton:(UIButton *)btn icon:(NSString *)icon{
    UIImage *image =[UIImage imageWithIcon:icon backgroundColor:[UIColor clearColor] iconColor:[UIColor colorWithHexString:@"FA4F18"] iconScale:1 andSize:CGSizeMake(24, 24)];
    [btn setImage:image forState:UIControlStateNormal];
}

-(void)setupUI{
    if([[ALBBSession sharedInstance] isLogin]){
        ALBBSession *session=[ALBBSession sharedInstance];
        ALBBUser *user = [session getUser];
        if (user.nick!=nil&&user.nick.length>0) {
            [self.loginButton setTitle:user.nick forState:UIControlStateNormal];
        }
        if (user.avatarUrl!=nil) {
            [self.headImage sd_setImageWithURL:[NSURL URLWithString:user.avatarUrl] placeholderImage:[UIImage imageNamed:@"head"]];
        }
        [WZModule uploadUserInfo:user.openId tbname:user.nick];
    }else{
        [self.loginButton setTitle:@"淘宝登录" forState:UIControlStateNormal];
        self.headImage.image=[UIImage imageNamed:@"head"];
    }
    
    NSString *code = [[PINCache sharedCache] objectForKey:@"myCode"];
    if (code!=nil) {
        self.codeText.text=[code URLDecodedString];
    }else{
        NSString *isloadcode = [[PINCache sharedCache] objectForKey:@"isloadcode"];
        if (isloadcode==nil) {
            NSMutableDictionary *param = [NSMutableDictionary new];
            NSString *imei=[[UIDevice currentDevice] identifierForVendor].UUIDString;
            param[@"imei"]=imei;
            param[@"type"]=@"IOS";
            NSString *signString = [self signStringSearch2:param];
            param[@"token"] = [signString md5String];
            
            [WZRequest GET:yhqinvitcodegetaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
                if (json!=nil) {
                    [[PINCache sharedCache] setObject:@"true" forKey:@"isloadcode"];
                    NSString *code = json[@"code"];
                    if (code!=nil) {
                        self.codeText.text=[code URLDecodedString];
                        [[PINCache sharedCache] setObject:code forKey:@"myCode"];
                    }
                }
            }];
        }
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self buttonLayout:self.myorderButton];
    [self buttonLayout:self.settingButton];
    [self buttonLayout:self.carButton];
    [self buttonLayout:self.collectionButton];
    [self buttonLayout:self.fkButton];
}

//button 上下布局
-(void)buttonLayout:(UIButton *)btn{
    if (![btn isKindOfClass:[UIButton class]]) {
        return;
    }
    
    CGFloat imageW = btn.imageView.frame.size.width;
    CGFloat imageH = btn.imageView.frame.size.height;
    
    CGFloat titleW = btn.titleLabel.frame.size.width;
    CGFloat titleH = btn.titleLabel.frame.size.height;
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageW, -imageH-13, 0.f)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-titleH, 0.f, 0.f,-titleW)];
    
    
    
}

-(void)login{
    [self loginClick:nil];
}
- (IBAction)loginClick:(id)sender {
    if(![[ALBBSession sharedInstance] isLogin]){
        [[ALBBSDK sharedInstance] auth:self successCallback:_loginSuccessCallback failureCallback:_loginFailedCallback];
    }
}

- (IBAction)myorderClick:(id)sender {
    if([[ALBBSession sharedInstance] isLogin]){
        __weak typeof(self) weakSelf = self;
        [YHLAlert showAlertinitWithTitle:@"提示" contentText:@"您还没有登录，需要马上登录吗？" leftButtonTitle:@"再看看" leftBlock:^{
            
        } rightButtonTitle:@"好的" rightBlock:^{
            [weakSelf loginClick:nil];
        }];
    }else{
//        DGMyOrderViewController *vc = [[DGMyOrderViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
        id<AlibcTradePage> page = [AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
        AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
        showParam.openType = [DGGlobalConfig openType];
        showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
        showParam.nativeFailMode=[DGGlobalConfig NativeFailMode];
        showParam.linkKey=[DGGlobalConfig schemeType];
        ALiTradeWebViewController* view = [[ALiTradeWebViewController alloc] init];
        [[AlibcTradeSDK sharedInstance].tradeService show:self webView:view.webView page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:nil tradeProcessFailedCallback:nil];
    }
}

- (IBAction)settingClick:(id)sender {
    WZCustomerSettingViewController *vc = [[WZCustomerSettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)carClick:(id)sender {
    if(![[ALBBSession sharedInstance] isLogin]){
        __weak typeof(self) weakSelf = self;
        [YHLAlert showAlertinitWithTitle:@"提示" contentText:@"您还没有登录，需要马上登录吗？" leftButtonTitle:@"再看看" leftBlock:^{
            
        } rightButtonTitle:@"好的" rightBlock:^{
            [weakSelf loginClick:nil];
        }];
    }else{
        DGCarViewController *vc = [[DGCarViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)colClick:(id)sender {
    
    DGMyCollectionViewController *vc = [[DGMyCollectionViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)fkClick:(id)sender {
    DGFeedbackViewController *vc = [[DGFeedbackViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)submitClick:(id)sender {
    NSString *code =self.codeText.text;
    if (code.length==0) {
        [[MyAlertView alertViewWithTitle:@"提示" message:@"邀请码不能为空！" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    }else{
        [self.view endEditing:YES];
        NSString *locaCode = [[PINCache sharedCache] objectForKey:@"myCode"];
        if ([code isEqualToString:locaCode]) {
            [[MyAlertView alertViewWithTitle:@"提示" message:@"恭喜！邀请码提交成功！" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            return;
        }
        NSMutableDictionary *param = [NSMutableDictionary new];
        NSString *imei=[[UIDevice currentDevice] identifierForVendor].UUIDString;
        param[@"imei"]=imei;
        param[@"type"]=@"IOS";
        param[@"code"]=[code stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
        NSString *signString = [self signStringSearch:param];
        param[@"token"] = [signString md5String];
        [WZRequest GET:yhqinvitcodesubmitaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
            if (json!=nil) {
                if ([json[@"errorCode"] integerValue]==0) {
                    [[MyAlertView alertViewWithTitle:@"提示" message:@"恭喜！邀请码提交成功！" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                    [[PINCache sharedCache] setObject:code forKey:@"myCode"];
                }else{
                    [[MyAlertView alertViewWithTitle:@"提示" message:@"邀请码输入错误" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                }
            }else{
                [[MyAlertView alertViewWithTitle:@"提示" message:@"邀请码输入错误" oALinClicked:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            }
        }];
    }
}

-(NSString *)signStringSearch:(NSDictionary *)dict{
    NSString *paramString=@"";
    
    
    paramString=[paramString stringByAppendingString:dict[@"imei"]];
    paramString=[paramString stringByAppendingString:dict[@"code"]];
//    paramString=[paramString stringByAppendingString:dict[@"type"]];
    paramString=[paramString stringByAppendingString:apptoken];
    
    return paramString;
}

-(NSString *)signStringSearch2:(NSDictionary *)dict{
    NSString *paramString=@"";
    
    paramString=[paramString stringByAppendingString:dict[@"imei"]];
    paramString=[paramString stringByAppendingString:apptoken];
    
    return paramString;
}

@end
