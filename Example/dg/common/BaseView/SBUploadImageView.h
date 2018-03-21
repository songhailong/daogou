//
//  SBUploadImageView.h
//  SBChe
//
//  Created by 万圣伟业 on 2017/3/7.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SBUploadImageViewDelegate <NSObject>
@required
- (void)currentImage :(UIImage *)image;
@end

@interface SBUploadImageView : UIImageView

@property (nonatomic, weak) id <SBUploadImageViewDelegate> delegate;

-(void)uploadImage;
@end
