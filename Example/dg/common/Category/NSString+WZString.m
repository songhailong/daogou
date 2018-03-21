//
//  NSString+WZString.m
//  12123_Example
//
//  Created by che on 2018/1/25.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "NSString+WZString.h"

@implementation NSString (WZString)

-(BOOL)isNotEmpty{
    if (self.length>0) {
        return YES;
    }else{
        return NO;
    }
}

/**
 *  URLEncode
 */
//- (NSString *)URLEncodedString
//{
//    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
//    // CharactersToLeaveUnescaped = @"[].";
//
//    NSString *unencodedString = self;
//    NSString *encodedString = (NSString *)
//    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
//                                                              (CFStringRef)unencodedString,
//                                                              NULL,
//                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
//                                                              kCFStringEncodingUTF8));
//
//    return encodedString;
//}

- (NSString *)URLEncodedString {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(kCFStringEncodingUTF8));
}

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *encodedString = self;
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}


@end
