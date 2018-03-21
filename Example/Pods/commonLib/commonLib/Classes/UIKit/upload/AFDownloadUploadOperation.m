#import "AFDownloadUploadOperation.h"

@implementation AFDownloadRequestOperation

+ (NSURLSessionDownloadTask *)downloadFileWithUrl:(NSString *)url TargetFilePath:(NSString *)targetFilePath DownloadProgress:(NetworkProgress)progress DownloadCompletion:(CompletionState)completion{
    // 1、 设置请求
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // 2、初始化
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    // 3、开始下载
    NSURLSessionDownloadTask * task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount,1.0 * downloadProgress.totalUnitCount,1.0 * downloadProgress.completedUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //这里要返回一个NSURL，其实就是文件的位置路径
        
        if (targetFilePath) {
            return [NSURL fileURLWithPath:targetFilePath];
        }
        
        NSString * path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //使用建议的路径
        path = [path stringByAppendingPathComponent:response.suggestedFilename];
        NSLog(@"destination %@",path);
        return [NSURL fileURLWithPath:path];//转化为文件路径
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //如果下载的是压缩包的话，可以在这里进行解压
        NSLog(@"completionHandler ----%@---%ld---%@",error.domain,error.code,error);
        //下载成功
        if (error == nil) {
            completion(YES,@"下载完成",[filePath path]);
        }else{//下载失败的时候，只列举判断了两种错误状态码
            NSString * message = nil;
            if (error.code == - 1005) {
                message = @"网络异常";
            }else if (error.code == -1001){
                message = @"请求超时";
            }else{
                message = @"未知错误";
            }
            completion(NO,message,nil);
        }
    }];
    
    [task resume];
    return task;
}

@end

@implementation AFUploadRequestOperation

+ (NSURLSessionUploadTask *)uploadFileWithUrl:(NSString *)url TargetFilePath:(NSURL *)targetFilePath UploadProgress:(NetworkProgress)progress UploadCompletion:(CompletionState)completion{
    // 1、 设置请求
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // 2、初始化
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    // 3、开始上传

    NSURLSessionUploadTask * task = [manager uploadTaskWithRequest:request fromFile:targetFilePath progress:^(NSProgress * _Nonnull uploadProgress) {
                progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount,1.0 * uploadProgress.totalUnitCount,1.0 * uploadProgress.completedUnitCount);
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        NSLog(@"completionHandler ----%@---%ld---%@",error.domain,error.code,error);
        //下载成功
        if (error == nil) {
            completion(YES,@"下载完成", @"file");
        }else{//下载失败的时候，只列举判断了两种错误状态码
            NSString * message = nil;
            if (error.code == - 1005) {
                message = @"网络异常";
            }else if (error.code == -1001){
                message = @"请求超时";
            }else{
                message = @"未知错误";
            }
            completion(NO,message,nil);
        }
    }];
    
    [task resume];
    return task;
}

+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url  parameters:(id)parameters headerFields:(id)headerFields
                                       name:(NSString *)name
                                   FromData:(NSData *)bodyData
                             UploadProgress:(NetworkProgress)progress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    return [self uploadFileWithUrl:url parameters:parameters headerFields:headerFields name:name FromDatas:@[bodyData] UploadProgress:progress success:success failure:failure];
}

+ (NSURLSessionDataTask *)uploadFileWithUrl:(NSString *)url parameters:(id)parameters  headerFields:(id)headerFields name:(NSString *)name
                                  FromDatas:(NSArray *)bodyDatas
                             UploadProgress:(NetworkProgress)progress
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration: configuration];
    for (NSString *key in [headerFields allKeys])
    {
        [manager.requestSerializer setValue:[headerFields objectForKey:key] forHTTPHeaderField:key];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/xml",@"text/plain", @"application/javascript", nil];
    NSURLSessionDataTask *task = [manager POST:url
                                    parameters: parameters
                     constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                         if (bodyDatas!=nil&&bodyDatas.count>0) {
                             for (NSData *bodyData in bodyDatas) {
                                 [formData appendPartWithFileData:bodyData name:name fileName:[NSString stringWithFormat:@"%d.jpeg",rand()%10000]  mimeType:@"image/jpeg"];
                             }
                             
                         }
                     }
                                      progress:^(NSProgress * _Nonnull uploadProgress) {
                                          progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount,1.0 * uploadProgress.totalUnitCount,1.0 * uploadProgress.completedUnitCount);
                                      } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          if (success)
                                          {
                                              success(task, responseObject);
                                          }
                                      }
                                       failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           if (failure)
                                           {
                                               failure(task, error);
                                           }
                                       }];
    
    return task;
    
    
}

@end
