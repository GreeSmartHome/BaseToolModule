//
//  GRRequestManager.m
//  AFNetworking
//
//  Created by 东哥 on 7/3/2020.
//

#import "GRRequestManager.h"
#import "AFNetworking.h"

@interface GRRequestManager ()

@property (nonatomic ,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation GRRequestManager

NSInteger const timeoutInterval = 30;
static GRRequestManager *manager = nil;

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}

- (void)setValue:(NSString *)value forHttpField:(NSString *)field {
    [self.sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (AFHTTPSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        config.timeoutIntervalForRequest = timeoutInterval;
        _sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSMutableSet *setM = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        [setM addObject:@"text/html"];
        [setM addObject:@"text/json"];
        [setM addObject:@"text/JavaScript"];
        [setM addObject:@"application/json"];
        [setM addObject:@"image/png"];
        _sessionManager.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionManager;
}


- (void)request:(RequestType)requestType urlStr: (NSString *)urlStr headers: (NSDictionary *)headers parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock {
    
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultBlock(responseObject, nil);
    };

    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil, error);
    };

    if (requestType == RequestTypeGET) {
        [self.sessionManager GET:urlStr parameters:param headers:headers progress:nil success:successBlock failure:failBlock];
    }else {
        [self.sessionManager POST:urlStr parameters:param headers:headers progress:nil success:successBlock failure:failBlock];
    };
    
}


@end
