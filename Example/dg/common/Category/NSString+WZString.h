//
//  NSString+WZString.h
//  12123_Example
//
//  Created by che on 2018/1/25.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WZString)
-(BOOL)isNotEmpty;

- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
@end
