//
//  SASharePanel.h
//  SAChe
//
//  Created by 万圣伟业 on 2017/8/2.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

//@protocol SASharePanelDelegate <NSObject>
//
//-(void)SASharePanelSelectItem:(NSInteger)index;
//
//@end

@interface SASharePanel : UIView

+(void)showShare: (NSString *)title content:(NSString *)content url:(NSString *)url imageName:(NSString *)imageName;


//@property (nonatomic, weak)id<SASharePanelDelegate> delegate;

@end
