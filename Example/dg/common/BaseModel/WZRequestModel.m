//
//  WZRequestModel.m
//  12123_Example
//
//  Created by che on 2018/1/22.
//  Copyright © 2018年 272789124@qq.com. All rights reserved.
//

#import "WZRequestModel.h"
#import <PINCache/PINCache.h>
#import "WZRequest.h"
@implementation WZRequestModel


- (NSArray *)loadCache
{
   
    NSDictionary *comments = [[PINCache sharedCache] objectForKey:[NSString stringWithFormat:@"%@",self.cacheKey]];
    if (comments)
    {
        baseHTTPResponse *response = [[baseHTTPResponse alloc] init];
        response.statusCode = @"success";
        response.responseData = comments;
        
        
        //解析数据
        NSArray *cacheDatas = self.parser(response);
        
        self.cacheDataSource = [[baseMutableDataSource alloc] init];
        [self.cacheDataSource addNewSection:self.title withItems:cacheDatas];
        
        return cacheDatas;
    }
    return nil;
}

- (void)parseParamOfDefaultResponse:(baseHTTPResponse *)response
{
    NSDictionary *pages =response.originData[@"pages"];
    int pageCount = [pages[@"pageCount"] intValue];
    int currentPage = [pages[@"currentPage"] intValue];
    self.canPageDown = pageCount>currentPage;
    if (self.canPageDown) {
        self.pagedownParameter[@"currentPage"] = @(currentPage+1).stringValue;
    }else{
        self.pagedownParameter[@"currentPage"] = @(currentPage).stringValue;
    }
    if (currentPage>1) {
        self.pageupParameter[@"currentPage"] = @(currentPage-1).stringValue;
    }else{
        self.pageupParameter[@"currentPage"] = @(1).stringValue;
    }
    
    self.parameter[@"currentPage"] = @(1).stringValue;
    
    //缓存第一页数据
    //[PINCache ym_setCacheObject:response.responseData forKey:[NSString stringWithFormat:@"%@",self.cacheKey]];
    
    [super parseParamOfDefaultResponse:response];
}

- (void)parseParamOfPageUpResponse:(baseHTTPResponse *)response
{
    
    NSDictionary *pages =response.originData[@"pages"];
    int pageCount = [pages[@"pageCount"] intValue];
    int currentPage = [pages[@"currentPage"] intValue];
    self.canPageDown = pageCount>currentPage;
    if (self.canPageDown) {
        self.pagedownParameter[@"currentPage"] = @(currentPage+1).stringValue;
    }else{
        self.pagedownParameter[@"currentPage"] = @(currentPage).stringValue;
    }
    if (currentPage>1) {
        self.pageupParameter[@"currentPage"] = @(currentPage-1).stringValue;
    }else{
        self.pageupParameter[@"currentPage"] = @(1).stringValue;
    }
    self.parameter[@"currentPage"] = @(1).stringValue;
    [super parseParamOfPageUpResponse:response];
}

- (void)parseParamOfPageDownResponse:(baseHTTPResponse *)response
{
    NSDictionary *pages =response.originData[@"pages"];
    int pageCount = [pages[@"pageCount"] intValue];
    int currentPage = [pages[@"currentPage"] intValue];
    self.canPageDown = pageCount>currentPage;
    
    if (self.canPageDown) {
        self.pagedownParameter[@"currentPage"] = @(currentPage+1).stringValue;
    }else{
        self.pagedownParameter[@"currentPage"] = @(currentPage).stringValue;
    }
    if (currentPage>1) {
        self.pageupParameter[@"currentPage"] = @(currentPage-1).stringValue;
    }else{
        self.pageupParameter[@"currentPage"] = @(1).stringValue;
    }
    
    self.parameter[@"currentPage"] = @(1).stringValue;
    [super parseParamOfPageDownResponse:response];
}

- (void)requestWithType:(baseTableRequestType)requestType
            paramSetter:(baseTableRequestModelParamSetter)paramSetter
                 parser:(baseTableRequestModelParser)parser
             completion:(void (^)(baseHTTPResponse *response, BOOL success))completion
{
    NSString *urlString = [self urlStringForRequestType:requestType];
    NSMutableDictionary *param = [self parameterForRequestType:requestType];
    
    
    if (paramSetter)
    {
        paramSetter(param,requestType);
    }
    NSMutableDictionary *header = nil;
    if (self.headerSetter)
    {
        header = [NSMutableDictionary dictionary];
        self.headerSetter(header,requestType);
    }
    
    
    [WZRequest POST:urlString parameters:param headerFields:header completion:^(WZResponse * _Nullable response) {
        
        BOOL success=NO;
        
        baseHTTPResponse *data =[[baseHTTPResponse alloc] init];
        data.code = response.statusCode;
        
        if (data.code==200) {
            data.originData = response.data;
            if ([data.originData isKindOfClass:[NSArray class]]) {
                data.responseData = data.originData;
            }else{
                data.responseData = data.originData[@"models"];
            }
            
            NSArray *items = parser(data);
            success=YES;
            if (requestType == baseTableRequestTypeDefault) {
                [self defaultDatasource:items];
                [self parseParamOfDefaultResponse:data];
            }
            else if (requestType == baseTableRequestTypePageUp)
            {
                [self pageUpDatasource:items];
                [self parseParamOfPageUpResponse:data];
            }
            else if (requestType == baseTableRequestTypePageDown)
            {
                [self pageDownDatasource:items];
                [self parseParamOfPageDownResponse:data];
            }
        }
        if (completion) {
            completion(data,success);
        }
    }];
    
}

@end
