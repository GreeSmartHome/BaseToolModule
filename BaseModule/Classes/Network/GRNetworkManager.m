//
//  GRNetworkManager.m
//  GRNetworkTest
//
//  Created by 冉东军 on 2020/2/23.
//  Copyright © 2020 Gree. All rights reserved.
//

#import "GRNetworkManager.h"
#import "AFNetworking.h"

@interface GRNetworkManager ()

@property (nonatomic ,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation GRNetworkManager

static GRNetworkManager *manager = nil;
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
        config.timeoutIntervalForRequest = 30.0f;
        _sessionManager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:config];
        NSMutableSet *setM = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [setM addObject:@"text/plain"];
        [setM addObject:@"text/html"];
        _sessionManager.responseSerializer.acceptableContentTypes = [setM copy];
    }
    return _sessionManager;
}

- (void)request:(RequestType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock {
    
    void(^successBlock)(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) = ^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        resultBlock(responseObject, nil);
    };

    void(^failBlock)(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) = ^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        resultBlock(nil, error);
    };

    if (requestType == RequestTypeGET) {
        [self.sessionManager GET:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    }else {
        [self.sessionManager POST:urlStr parameters:param progress:nil success:successBlock failure:failBlock];
    };
    
}


@end
