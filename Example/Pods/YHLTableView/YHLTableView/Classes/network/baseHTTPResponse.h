//
//  baseHTTPResponse.h
//  Pods
//
//  Created by yangshiyu on 2017/2/13.
//
//

#import <Foundation/Foundation.h>

@interface baseHTTPResponse : NSObject
@property (nonatomic, strong) id originData; // 原始数据

@property (nonatomic, strong) id responseData; // 标准JSON返回格式中的data数据, 非标准格式中为nil
@property (nonatomic, strong) NSString *statusCode; //
@property (nonatomic, assign) NSInteger code; //
@property (nonatomic, assign) NSInteger page_num;
@property (nonatomic, strong) NSDate *updateTime; // 更新时间
@property (nonatomic, strong) NSString *message; // 消息, 一般为错误消息


@property (nonatomic, strong) NSError *error;


/**
 *  创建HTTP响应对象
 *
 *  @param object JSON数据, 格式可能是数组或字典
 *
 *  @return
 */
+ (instancetype)responseWithObject:(id)object;
+ (instancetype)responseWithError:(NSError *)error;

/**
 *  是否是标准的JSON返回格式,
 *
 *  @param responseObject JSON数据
 *
 *  @return 是否
 */
+ (BOOL)isStandardResponse:(id)responseObject;



@end
