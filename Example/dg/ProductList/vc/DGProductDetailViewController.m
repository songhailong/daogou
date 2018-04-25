//
//  DGProductDetailViewController.m
//  dg_Example
//
//  Created by che on 2018/4/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "DGProductDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DGListModel.h"
#import "DGTopCellView.h"
#import "UIView+WZXibView.h"
#import <commonLib/UIImage+Utility.h>
#import <commonLib/UIColor+HexString.h>
#import <commonLib/UIImage+FontAwesome.h>
#import "UIButton+WZButton.h"
#import <PINCache/PINCache.h>
#import "SASharePanel.h"
#import "DGGlobalConfig.h"
@interface DGProductDetailViewController ()
@property (nonatomic,strong) NSString *prdtId;
@property (nonatomic,strong) NSDictionary *item;

@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;

@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *marketLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellLabel;
@property (weak, nonatomic) IBOutlet UILabel *couponLabel;
@property (weak, nonatomic) IBOutlet UILabel *endtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UIView *productListView;
@property (weak, nonatomic) IBOutlet UIButton *colButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightC;

@property (weak, nonatomic) IBOutlet UIButton *shopButton;

- (IBAction)couponClick:(id)sender;
- (IBAction)shopClick:(id)sender;
- (IBAction)colClick:(id)sender;
- (IBAction)shareClick:(id)sender;



@end

@implementation DGProductDetailViewController

-(instancetype) initWithId:(NSString *)prdtId{
    self = [self init];
    if (self) {
        self.prdtId=prdtId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"商品详情";
    [self resetButton:self.colButton icon:@"icon-star"];
    [self resetButton:self.shareButton icon:@"em-icon-share"];
    [self loadProductDetail];
    
    _onTradeSuccess=^(AlibcTradeResult *tradeProcessResult){
        NSLog(@"aa===%lu",(unsigned long)tradeProcessResult.result);
    };
    _onTradeFailure=^(NSError *error){
        NSLog(@"打开订单失败");
    };
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self buttonLayout:self.colButton];
    [self buttonLayout:self.shareButton];
    [self.shopButton resetLayout];
}

-(void)loadProductDetail{
    NSMutableDictionary *param = [NSMutableDictionary new];
    NSString *imei=[[UIDevice currentDevice] identifierForVendor].UUIDString;
    param[@"imei"]=imei;
    param[@"type"]=@"IOS";
    param[@"prdtId"]=self.prdtId;
    
    
    NSString *signString = [self signStringSearch:param];
    param[@"token"] = [signString md5String];
    [WZRequest GET:yhqcouponmsgaction parameters:param headerFields:nil completion:^(id  _Nullable json, JSONModelError * _Nullable err) {
        if (json!=nil) {
            NSDictionary *item = json[@"coupon"];
            self.item=item;
            [self.productImage sd_setImageWithURL:[NSURL URLWithString:item[@"prdtImgUrl"]] placeholderImage:nil];
            self.nameLabel.text=item[@"prdtName"];
            self.desLabel.text=item[@"couponInfo"];
            CGFloat price = [item[@"prdtPrice"] floatValue];
            CGFloat couponvalue =[item[@"couponValue"] floatValue];
            self.priceLabel.text=[NSString stringWithFormat:@"优惠价:¥%.1f",price-couponvalue];
            self.marketLabel.text=[NSString stringWithFormat:@"¥%.1f",price];

            NSInteger couponTotalCount = [item[@"couponTotalCount"] integerValue];
            NSInteger couponRemainCount =[item[@"couponRemainCount"] integerValue];
            self.sellLabel.text = [NSString stringWithFormat:@"销量:%ld件",couponTotalCount-couponRemainCount];
            
            self.couponLabel.text=[NSString stringWithFormat:@"%.1f元优惠券",couponvalue];
            self.endtimeLabel.text=[NSString stringWithFormat:@"截止日期:%@",item[@"couponEndTime"]];
            self.shopNameLabel.text=item[@"shopName"];
            NSArray *tops = [DGListModel parseArray:json[@"coupons"]];
            [self loadToping:tops];
            
        }else{
            [MBProgressHUD showToast:@"该商品已下架"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark top
-(void)loadToping:(NSArray *)array{
    NSInteger index=0;
    for (DGListModel *model in array) {
        CGRect frame =CGRectMake(0, index*150+30, WZwidth-10, 150);
        DGTopCellView *rankingView = [DGTopCellView initWithXibWithFrame:frame];
        [rankingView update:model];
        [self.productListView addSubview:rankingView];
        index++;
    }
    self.heightC.constant=150*index+30;
}

-(NSString *)signStringSearch:(NSDictionary *)dict{
    NSString *paramString=@"";

    paramString=[paramString stringByAppendingString:dict[@"imei"]];

    paramString=[paramString stringByAppendingString:apptoken];
    
    return paramString;
}
- (IBAction)couponClick:(id)sender {
    [self openCar];
}

- (IBAction)shopClick:(id)sender {
}

- (IBAction)colClick:(id)sender {
    
    NSMutableArray *items = [[PINCache sharedCache] objectForKey:@"collectionProductList"];
    if (items==nil) {
        items=[NSMutableArray new];
    }
    if (items.count>20) {
        [items removeObject:items.firstObject];
    }else{
        BOOL isAdd=YES;
        for (NSDictionary *dict in items) {
            NSString *pid = [NSString stringWithFormat:@"%@",dict[@"prdtId"]];
            if ([pid isEqualToString:self.prdtId]) {
                isAdd=NO;
                break;
            }
        }
        if (isAdd) {
            [items addObject:self.item];
        }
    }
    [[PINCache sharedCache] setObject:items forKey:@"collectionProductList"];
    
    [MBProgressHUD showDelaySuccess:@"收藏成功,我在用户中心查看！"];
}

- (IBAction)shareClick:(id)sender {
    CGFloat price = [self.item[@"prdtPrice"] floatValue];
    CGFloat couponvalue =[self.item[@"couponValue"] floatValue];
    self.priceLabel.text=[NSString stringWithFormat:@"优惠价:¥%.1f",price-couponvalue];
    self.marketLabel.text=[NSString stringWithFormat:@"¥%.1f",price];
    [SASharePanel  showShare:self.item[@"prdtName"] content:[NSString stringWithFormat:@"原价%.2f,券后%.2f 立刻下载app 购买",price,price-couponvalue] url:@"https://itunes.apple.com/us/app/id1369884700?mt=8" imageName:@"40"];
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
-(void)resetButton:(UIButton *)btn icon:(NSString *)icon{
    UIImage *image =[UIImage imageWithIcon:icon backgroundColor:[UIColor clearColor] iconColor:[UIColor colorWithHexString:@"FA4F18"] iconScale:1 andSize:CGSizeMake(20, 20)];
    [btn setImage:image forState:UIControlStateNormal];
}


- (void)openCar {
//    id<AlibcTradePage> page = [AlibcTradePageFactory itemMiniDetailPage:[NSString stringWithFormat:@"%@",self.prdtId]];
    id<AlibcTradePage> page = [AlibcTradePageFactory page:self.item[@"couponClickUrl"]];
    
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    showParam.openType = [DGGlobalConfig openType];
    showParam.backUrl=[ALiTradeSDKShareParam sharedInstance].backUrl;
    showParam.nativeFailMode=[DGGlobalConfig NativeFailMode];
    showParam.linkKey=[DGGlobalConfig schemeType];
    
    ALiTradeWebViewController* view = [[ALiTradeWebViewController alloc] init];
    
    [[AlibcTradeSDK sharedInstance].tradeService show:self webView:view.webView page:page showParams:showParam taoKeParams:[DGGlobalConfig taokeParam] trackParam:[DGGlobalConfig customParam] tradeProcessSuccessCallback:self.onTradeSuccess tradeProcessFailedCallback:self.onTradeFailure];
    
}

@end
