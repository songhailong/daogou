#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void(^NetworkProgress) (CGFloat progress,CGFloat total,CGFloat current);
typedef void(^CompletionState) (BOOL state,NSString * message,NSString * filePath);


@interface AFDownloadRequestOperation : NSObject
+ (NSURLSessionDownloadTask *)downloadFileWithUrl:(NSString *)url TargetFilePath:(NSString *)targetFilePath DownloadProgress:(NetworkProgress)progress DownloadCompletion:(CompletionState)completion;

@end

@interface AFUploadRequestOperation : NSObject
+ (NSURLSessionUploadTask *)uploadFileWithUrl:(NSString *)url TargetFilePath:(NSURL *)targetFilePath UploadProgress:(NetworkProgress)progress UploadCompletion:(CompletionState)completion;

+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url parameters:(id)parameters  headerFields:(id)headerFields name:(NSString *)name
                                   FromData:(NSData *)bodyData
                             UploadProgress:(NetworkProgress)progress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url parameters:(id)parameters headerFields:(id)headerFields name:(NSString *)name
                                  FromDatas:(NSArray *)bodyDatas
                             UploadProgress:(NetworkProgress)progress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
