//
//  YHLAlert.m
//  SAChe
//
//  Created by 万圣伟业 on 2017/5/25.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "YHLAlert.h"
#import <commonLib/MSActiveControllerFinder.h>
@implementation YHLAlert

+ (void)showAlertWithTitle:(NSString *)title
               contentText:(NSString *)content{
    UIAlertController *tipVc  = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [tipVc addAction:cancleAction];
    UIViewController *currentVC = [MSActiveControllerFinder finder].activeTopController();
    [currentVC presentViewController:tipVc animated:YES completion:nil];

}

+ (void)showAlertWithTitle:(NSString *)title
               contentText:(NSString *)content
               buttonTitle:(NSString *)buttonTitle
                     block:(YHLAlertBlick)block{
    UIAlertController *tipVc  = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        block();
    }];
    [tipVc addAction:cancleAction];
    UIViewController *currentVC = [MSActiveControllerFinder finder].activeTopController();
    [currentVC presentViewController:tipVc animated:YES completion:nil];
}

+ (void)showAlertinitWithTitle:(NSString *)title
                   contentText:(NSString *)content
               leftButtonTitle:(NSString *)leftTitle
                     leftBlock:( YHLAlertBlick)leftBlock
              rightButtonTitle:(NSString *)rigthTitle
                    rightBlock:( YHLAlertBlick)rightBlock{
    UIAlertController *tipVc  = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:leftTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        leftBlock();
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:rigthTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        rightBlock();
        
    }];
    [tipVc addAction:cancleAction];
    [tipVc addAction:okAction];
    UIViewController *currentVC = [MSActiveControllerFinder finder].activeTopController();
    [currentVC presentViewController:tipVc animated:YES completion:nil];
}

+ (void)showAlertControllerStyleActionSheet:(NSArray<NSString *> *)datasource block:(YHLAlertBlockSheet)block{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
     [alertVc addAction:cancle];
    for (NSString *value in datasource) {
        UIAlertAction *camera = [UIAlertAction actionWithTitle:value style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            
            NSInteger index = [datasource indexOfObject:action.title];
            
            block(index);
            
        }];
         [alertVc addAction:camera];
    }
    
    UIViewController *currentVC = [MSActiveControllerFinder finder].activeTopController();
    [currentVC presentViewController:alertVc animated:YES completion:nil];
}
@end
