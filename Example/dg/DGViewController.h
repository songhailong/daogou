//
//  DGViewController.h
//  dg
//
//  Created by 272789124@qq.com on 03/14/2018.
//  Copyright (c) 2018 272789124@qq.com. All rights reserved.
//

@import UIKit;
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
@interface DGViewController : UIViewController

@property (nonatomic, strong) AlibcTradeProcessSuccessCallback onTradeSuccess;
@property (nonatomic, strong) AlibcTradeProcessFailedCallback onTradeFailure;
@end
