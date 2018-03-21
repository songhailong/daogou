//
//  yhlSessionManager.h
//  Pods
//
//  Created by yanghonglei on 16/7/8.
//
//

#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>

@protocol MSHTTPSessionDebugHandler <NSObject>

- (void)handleRequestError:(nonnull NSError *)error;

- (void)handleRequestFlowData:(nonnull NSString *)URL
                  downLoadLen:(NSUInteger)download
                    uploadLen:(NSUInteger)upload;
@end

typedef void (^JSONObjectBlock)(__nullable id json, JSONModelError* _Nullable  err);

@interface yhlSessionManager : AFHTTPSessionManager
{
    
}

#pragma mark property
@property (nonatomic, strong) __nullable id <MSHTTPSessionDebugHandler> debugHandler;

#pragma method
+ (nonnull instancetype)sharedManager;

- (nullable NSURLSessionDataTask *)GET:(nonnull NSString *)URLString
                            parameters:(nullable id)parameters
                          headerFields:(nullable id)headerFields
                            completion:(nullable JSONObjectBlock)completeBlock;

- (nullable NSURLSessionDataTask *)GET_Extend:(nonnull NSString *)URLString
                               parameters:(nullable id)parameters
                             headerFields:(nullable id)headerFields
                           JSONModelClass:(nonnull Class)jsonModelClass
                               completion:(nullable JSONObjectBlock)completeBlock;

- (nullable NSURLSessionDataTask *)POST:(nonnull NSString *)URLString
                             parameters:(nullable id)parameters
                           headerFields:(nullable id)headerFields
                             completion:(nullable JSONObjectBlock)completeBlock;

- (nullable NSURLSessionDataTask *)POST_Extend:(nonnull NSString *)URLString
                                parameters:(nullable id)parameters
                              headerFields:(nullable id)headerFields
                            JSONModelClass:(nonnull Class)jsonModelClass
                                completion:(nullable JSONObjectBlock)completeBlock;


@end
