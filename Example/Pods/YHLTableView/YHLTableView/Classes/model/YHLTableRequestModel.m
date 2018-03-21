//
//  baseTableRequestModel.m
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import "YHLTableRequestModel.h"

@implementation YHLTableRequestModel

- (id)init
{
    self = [super init];
    if (self) {
        self.parameter = [NSMutableDictionary dictionary];
        self.pageupParameter   = [NSMutableDictionary dictionary];
        self.pagedownParameter = [NSMutableDictionary dictionary];
        self.requestType = baseTableRequestTypeDefault;
        self.title = @"";
        self.items = [NSMutableArray array];
        self.canPageDown = NO;
    }
    return self;
}

- (NSMutableDictionary *)parameterForRequestType:(baseTableRequestType)requestType
{
    NSMutableDictionary *param = nil;
    switch (requestType) {
        case baseTableRequestTypeDefault:
            param = self.parameter;
            break;
        case baseTableRequestTypePageDown:
            param = self.pagedownParameter;
            break;
        case baseTableRequestTypePageUp:
            param = self.pageupParameter;
            break;
        default:
            break;
    }
    
    return param;
}

- (NSString *)urlStringForRequestType:(baseTableRequestType)requestType
{
    NSString *urlString = self.URLString;
    if (requestType == baseTableRequestTypePageDown && self.pageDownUrlString)
    {
        urlString = self.pageDownUrlString;
    }
    return urlString;
}

- (void)requestWithType:(baseTableRequestType)requestType
            paramSetter:(baseTableRequestModelParamSetter)paramSetter
                 parser:(baseTableRequestModelParser)parser
             completion:(void (^)(baseHTTPResponse *response, BOOL success))completion{
    
    NSString *urlString = [self urlStringForRequestType:self.requestType];
    NSMutableDictionary *param = [self parameterForRequestType:self.requestType];
    if (self.paramSetter)
    {
        self.paramSetter(param,self.requestType);
    }
    NSMutableDictionary *header = nil;
    if (self.headerSetter)
    {
        header = [NSMutableDictionary dictionary];
        self.headerSetter(header,self.requestType);
    }
    __weak __typeof(self) weakSelf = self;
    [self GET:urlString
   parameters:param
 headerFields:header
        block:^(baseHTTPResponse *response, NSURLSessionTask *task, BOOL success) {
            
            if (success && [response.statusCode isEqualToString: @"success"])
            {
                NSArray *items = weakSelf.parser(response);
                if ([response.statusCode  isEqualToString: @"success"])
                {
                    if (weakSelf.requestType == baseTableRequestTypeDefault) {
                        [weakSelf defaultDatasource:items];
                        [weakSelf parseParamOfDefaultResponse:response];
                    }
                    else if (weakSelf.requestType == baseTableRequestTypePageUp)
                    {
                        [weakSelf pageUpDatasource:items];
                        [weakSelf parseParamOfPageUpResponse:response];
                    }
                    else if (weakSelf.requestType == baseTableRequestTypePageDown)
                    {
                        [weakSelf pageDownDatasource:items];
                        [weakSelf parseParamOfPageDownResponse:response];
                    }
                }
            }
            else
            {
                success = NO;
            }
            
            if (completion) {
                completion(response,success);
            }
        }];
    
}
- (void)requestWithType:(void (^)(baseHTTPResponse *response, BOOL success))completion
{
    [self requestWithType:self.requestType paramSetter:self.paramSetter parser:self.parser completion:completion];
}

- (void)parseParamOfDefaultResponse:(baseHTTPResponse *)response
{
    if ([response.originData isKindOfClass:[NSDictionary class]])
    {
        //parameter
//        self.pageDownUrlString = response.originData[@"nextPage"];
//        self.canPageDown = [response.originData[@"hasNextPage"] boolValue];
//        
//        self.pagedownParameter[@"lastid"] = response.originData[@"lastid"];
//        self.pageupParameter[@"topid"] = response.originData[@"topid"];
    }
}

- (void)parseParamOfPageDownResponse:(baseHTTPResponse *)response
{
    if ([response.originData isKindOfClass:[NSDictionary class]])
    {
        //parameter
//        self.pageDownUrlString = response.originData[@"nextPage"];
//        self.canPageDown = [response.originData[@"hasNextPage"] boolValue];
//        self.pagedownParameter[@"lastid"] = response.originData[@"lastid"];
    }
}

- (void)parseParamOfPageUpResponse:(baseHTTPResponse *)response
{
    if ([response.originData isKindOfClass:[NSDictionary class]])
    {
        //parameter
//        self.pageupParameter[@"topid"] = response.originData[@"topid"];
    }
}

- (void)defaultDatasource:(NSArray *)datas
{
    //datasource
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:datas];
    baseMutableDataSource *dataSource = [[baseMutableDataSource alloc] init];
    [dataSource addNewSection:self.title withItems:self.items];
    self.dataSource = dataSource;
}

- (void)pageDownDatasource:(NSArray *)datas
{
    //datasource
    if (datas && datas.count)
    {
        [self.items addObjectsFromArray:datas];
        NSInteger index = [self.dataSource.sections indexOfObject:self.title];
        [self.dataSource removeSection:index];
        [self.dataSource addNewSection:self.title withItems:self.items];
    }
}

- (void)pageUpDatasource:(NSArray *)datas
{
    //datasource
    if(self.dataSource)
    {
        [self.items insertObjects:datas atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, datas.count)]];
        NSInteger index = [self.dataSource.sections indexOfObject:self.title];
        [self.dataSource removeSection:index];
        [self.dataSource addNewSection:self.title withItems:self.items];
    }
    else
    {
        [[self items] removeAllObjects];
        [self.items addObjectsFromArray:datas];
        baseMutableDataSource *dataSource = [[baseMutableDataSource alloc] init];
        [dataSource addNewSection:self.title withItems:self.items];
        self.dataSource = dataSource;
    }
}


- (void)dealloc
{
    self.paramSetter = nil;
    self.parser = nil;
    self.eventHandler = nil;
}

@end
