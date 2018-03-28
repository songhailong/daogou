//
//  WZCustomerSettingViewController.m
//  12123_Example
//
//  Created by che on 2018/1/23.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZCustomerSettingViewController.h"
#import "WZCustomerSettingItemCellModel.h"
#import "WZModule.h"
#import <commonLib/YHLAlert.h>
#import "WZModule.h"
#import "PINCache+YMCache.h"
#import <SDWebImage/SDImageCache.h>
#import <commonLib/BDKNotifyHUD.h>
#import "WZSettingImportantViewController.h"
#import <commonLib/UIApplication+NotificationSettings.h>
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "DGGlobalConfig.h"
@interface WZCustomerSettingViewController ()

@end

@implementation WZCustomerSettingViewController


-(NSArray<NSString *> *)xibNameOfCell{
    return @[@"WZCustomerSettingTableViewCell"];
}

-(void)loadView{
    [super loadView];
    self.didSupportHeaderRefreshing=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"设置";
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor=[UIColor colorWithHexString:@"f5f5f5"];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(void)headerRefreshing{
    
    baseMutableDataSource *dataSource = [[baseMutableDataSource alloc] init];
    
    
//    WZCustomerSettingItemCellModel *pushModel = [WZCustomerSettingItemCellModel instanceWithData:@{@"title":@"推送设置",@"subTitle":@"未开启",@"Id":@"2",@"isLogout":@(NO)}];
    
    CGFloat cacheSize = [self checkCache];
    NSString *cache =[NSString stringWithFormat:@"%.1fMB",cacheSize];
    WZCustomerSettingItemCellModel *cacheModel = [WZCustomerSettingItemCellModel instanceWithData:@{@"title":@"清理缓存",@"subTitle":cache,@"Id":@"3",@"isLogout":@(NO)}];
    
    NSArray *twoGroup = @[cacheModel];
    if([UIApplication sharedApplication].EMNotificationSettingTypes==UIUserNotificationTypeNone){
        twoGroup = @[cacheModel];
    }
    
    [dataSource addNewSection:@"" withItems:twoGroup];
    
    WZCustomerSettingItemCellModel *statementModel = [WZCustomerSettingItemCellModel instanceWithData:@{@"title":@"关于我们",@"subTitle":@"",@"Id":@"4",@"isLogout":@(NO)}];
    NSArray *threeGroup = @[statementModel];
    [dataSource addNewSection:@"" withItems:threeGroup];
    
    if([[ALBBSession sharedInstance] isLogin]){
        WZCustomerSettingItemCellModel *logoutModel = [WZCustomerSettingItemCellModel instanceWithData:@{@"title":@"",@"subTitle":@"",@"Id":@"5",@"isLogout":@(YES)}];
        NSArray *fourGroup = @[logoutModel];
        [dataSource addNewSection:@"" withItems:fourGroup];
    }
    
    [self reloadPages:dataSource];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WZCustomerSettingItemCellModel *model =(WZCustomerSettingItemCellModel *)[self.dataSource itemAtIndexPath:indexPath];
    if (model.isLogout) {
        [YHLAlert showAlertinitWithTitle:@"提示" contentText:@"确定要退出登录吗?" leftButtonTitle:@"再想想" leftBlock:^{
            
        } rightButtonTitle:@"确定" rightBlock:^{
            [[ALBBSDK sharedInstance] logoutWithCallback:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCarNot" object:nil];
                [self headerRefreshing];
            }];
            
        }];
    }else if(model.Id==2){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }else if(model.Id==3){
        [self removeCache];
    }else if (model.Id==4){
        WZSettingImportantViewController *vc = [[WZSettingImportantViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)removeCache {
    __weak __typeof(self)weakSelf = self;
    [YHLAlert showAlertinitWithTitle:@"清理缓存" contentText:@"缓存内容删除后不可恢复，确认清理吗？" leftButtonTitle:@"取消" leftBlock:^{
        //
    } rightButtonTitle:@"确定" rightBlock:^{
        [[PINCache commonCache] removeAllObjects];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            
        }];
       
        [BDKNotifyHUD showNotifHUDWithTextBottom:@"清理缓存成功"];
         [weakSelf headerRefreshing];
    }];
    
}

-(CGFloat)checkCache{
    
    float pincacheSize = ([PINCache commonCache].diskByteCount/1024.0f)/1024.0f;
    
    NSUInteger imageSize = [[SDImageCache sharedImageCache] getSize];
    float floatSize = (imageSize/1024.0f)/1024.0f;
    
    NSUInteger size = 0;
    NSFileManager *fileManager =[NSFileManager defaultManager];
    NSString * localPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    localPath = [localPath stringByAppendingPathComponent:@"voice"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:localPath]) {
        NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:localPath];
        for (NSString *fileName in fileEnumerator) {
            NSString *filePath = [localPath stringByAppendingPathComponent:fileName];
            NSDictionary<NSString *, id> *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
            size += [attrs fileSize];
        }
    }
    float voicesize=(size/1024.0f)/1024.0f;
    
    float totalSize=pincacheSize+floatSize+voicesize;
    
    return  totalSize;
//    [self.cacheButton setTitle:[NSString stringWithFormat:@"%.1fMB",totalSize] forState:UIControlStateNormal];
    
}

@end
