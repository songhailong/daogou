//
//  baseTableRequestModel.h
//  Pods
//
//  Created by yang on 16/6/3.
//
//

#import "baseHTTPRequestModel.h"
#import "baseMutableDataSource.h"
#import "baseHTTPResponse.h"
typedef NS_ENUM(NSUInteger, baseTableRequestType) {
    baseTableRequestTypeDefault,//刷新数据
    baseTableRequestTypePageUp,//新增数据
    baseTableRequestTypePageDown,//翻页数据
    baseTableRequestTypeCache,//缓存
};

typedef void (^baseTableRequestModelParamSetter)(NSMutableDictionary *param, baseTableRequestType requestType);
typedef void (^baseTableRequestModelHeaderSetter)(NSMutableDictionary *header, baseTableRequestType requestType);
//typedef void (^addParamToURL)(NSMutableDictionary *param);
typedef NSArray *(^baseTableRequestModelParser)(baseHTTPResponse *response);


typedef void (^baseTableViewCellEventHandler)(UITableViewCell *cell,id cellmodel,id sender, NSIndexPath *indexPath,id userInfo);


@protocol baseTableViewCellEventHandler <NSObject>

@property (nonatomic, copy)baseTableViewCellEventHandler eventHandler;

@end


@interface YHLTableRequestModel : baseHTTPRequestModel<baseTableViewCellEventHandler>

@property (nonatomic, strong) NSString *cacheKey; //需要缓存数据 才需要对此字段赋值
@property (nonatomic, strong) baseMutableDataSource *cacheDataSource;

@property (nonatomic, strong) NSString *URLString;
@property (nonatomic, strong) NSString *pageDownUrlString;
@property (nonatomic, strong) NSMutableDictionary *pageupParameter; //上翻页参数
@property (nonatomic, strong) NSMutableDictionary *pagedownParameter; //下翻页参数
@property (nonatomic, strong) NSMutableDictionary *parameter; //参数
@property (nonatomic, assign) BOOL canPageDown;//当前是否可以翻页

@property (nonatomic, strong) baseMutableDataSource *dataSource; //列表数据源
@property (nonatomic, assign) baseTableRequestType requestType;
@property (nonatomic, strong) NSMutableArray *items; //所有请求到的原始数据

@property (nonatomic, copy) baseTableRequestModelParamSetter paramSetter;//默认为空
@property (nonatomic, copy) baseTableRequestModelHeaderSetter headerSetter;
@property (nonatomic, copy) baseTableRequestModelParser parser;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, copy)baseTableViewCellEventHandler eventHandler;


- (void)requestWithType:(baseTableRequestType)requestType
            paramSetter:(baseTableRequestModelParamSetter)paramSetter
                 parser:(baseTableRequestModelParser)parser
             completion:(void (^)(baseHTTPResponse *response, BOOL success))completion;

- (void)requestWithType:(void (^)(baseHTTPResponse *response, BOOL success))completion;

/**
 *解析多种请求后的参数、数据
 *parseParam  解析参数
 *parseDatasource 解析获得dataSource
 *列表视图如果数据结构跟默认不同的，可通过复写一下方法进行自定义
 */
#pragma mark -
#pragma mark parser

- (void)parseParamOfDefaultResponse:(baseHTTPResponse *)response;
- (void)parseParamOfPageDownResponse:(baseHTTPResponse *)response;
- (void)parseParamOfPageUpResponse:(baseHTTPResponse *)response;

- (void)defaultDatasource:(NSArray *)datas;
- (void)pageDownDatasource:(NSArray *)datas;
- (void)pageUpDatasource:(NSArray *)datas;

- (NSMutableDictionary *)parameterForRequestType:(baseTableRequestType)requestType;
- (NSString *)urlStringForRequestType:(baseTableRequestType)requestType;
@end
