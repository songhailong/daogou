//
//  CCWXShare.h
//  che
//
//  Created by 万圣伟业 on 2017/8/24.
//  Copyright © 2017年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCWXShare : NSObject

+ (void) sendLinkContent:(int)sharetype title:(NSString *)title content:(NSString *)content imageName:(NSString *)imageName url:(NSString *)url;

+ (void) sendTextContent :(int)sharetype content:(NSString *)content;
@end
