//
//  baseURLProtocol.h
//  Pods
//
//  Created by yangshiyu on 2017/2/13.
//
//

#import <Foundation/Foundation.h>

extern NSString * const kMSURLPROTOCOLFORSERVERADDRESSKEY; //用来作为是否设置protocolClasses的key

@protocol baseURLProtocolURLMapping <NSObject>

- (NSString *)newHostForOriginalURLHost:(NSString *)originalURLHost;

@end

@interface baseURLProtocol : NSURLProtocol


+ (void)registerURLProtocolWithURLMapping:(id<baseURLProtocolURLMapping>)URLMapping;

// 如果使用AF，可以不调用这个方法
+ (void)start;

//设置支持的schemes，默认支持http和https
+ (void)setSupportedSchemes:(NSSet *)supportedSchemes;

@end
