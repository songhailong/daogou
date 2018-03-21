//
//  baseHTTPResponse.m
//  Pods
//
//  Created by yangshiyu on 2017/2/13.
//
//

#import "baseHTTPResponse.h"

@interface baseHTTPResponse() {
    
}
+ (NSDateFormatter *)updateTimeFormatter;
@end

@implementation baseHTTPResponse

+ (instancetype)responseWithObject:(id)object
{
    return [baseHTTPResponse responseWithDictionary:object];
}

+ (instancetype)responseWithDictionary:(NSDictionary *)responseObject
{
    return [[baseHTTPResponse alloc] initWithDictionary:responseObject];
}

- (id)initWithDictionary:(NSDictionary *)responseObject
{
    self = [super init];
    
    if (self) {
        self.originData = responseObject;
        
        if ([baseHTTPResponse isStandardResponse:responseObject]) {
            self.statusCode = responseObject[@"statusCode"];
            NSDateFormatter *formatter = [baseHTTPResponse updateTimeFormatter];
            self.updateTime = [formatter dateFromString:responseObject[@"updatetime"]];
            self.responseData = responseObject[@"data"];
            self.message = responseObject[@"message"];
        }
    }
    
    return self;
}

+ (instancetype)responseWithError:(NSError *)error
{
    baseHTTPResponse *response = [[baseHTTPResponse alloc] initWithDictionary:nil];
    response.error = error;
    return response;
}

+ (NSDateFormatter *)updateTimeFormatter
{
    static NSDateFormatter *_dateFormatter = nil;
    if (_dateFormatter == nil)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    
    return _dateFormatter;
}

+ (BOOL)isStandardResponse:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]
        && responseObject[@"statusCode"]
        && responseObject[@"data"])
    {
        return YES;
    }
    
    return NO;
}
@end
