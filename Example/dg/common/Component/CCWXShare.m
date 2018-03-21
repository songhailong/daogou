//
//  CCWXShare.m
//  che
//
//  Created by 万圣伟业 on 2017/8/24.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import "CCWXShare.h"
#import <WechatOpenSDK/WXApi.h>
@implementation CCWXShare

+ (void) sendLinkContent:(int)sharetype title:(NSString *)title content:(NSString *)content imageName:(NSString *)imageName url:(NSString *)url
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = content;
    
    UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]];
    if (![imageName containsString:@"http"]) {
        desImage = [UIImage imageNamed:imageName];
    }
//    UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(150, 150)];
    [message setThumbImage:desImage];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    //WXSceneSession 好友。 WXSceneTimeline 朋友圈
    req.scene = sharetype;
    
    [WXApi sendReq:req];
}



+ (void) sendTextContent :(int)sharetype content:(NSString *)content
{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.text = content;
    req.bText = YES;
    req.scene = WXSceneTimeline;
    
    [WXApi sendReq:req];
}


+ (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize
{
    if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
        return scImg;
    }
    CGSize thumbSize;
    if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
        thumbSize.width = limitSize.width;
        thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
    }
    else {
        thumbSize.height = limitSize.height;
        thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
    }
    UIGraphicsBeginImageContext(thumbSize);
    [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImg;
}


@end
