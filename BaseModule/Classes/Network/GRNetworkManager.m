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


@property (nonatomic ,strong) AFNetworkReachabilityManager *networkManager;

@property (nonatomic ,assign) NetworkType type;

@end

@implementation GRNetworkManager

static GRNetworkManager *manager=nil;

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

- (instancetype)init {
    if (self) {
        self = [super init];
        
        [self setupNetWorkManager];
    }
    return self;
}

- (void)setupNetWorkManager {
    //初始化
    self.type = NetworkTypeUnknow;
    
    //1.创建网络状态监测管理者
    self.networkManager = [AFNetworkReachabilityManager sharedManager];
    
    __weak typeof (self) weakSelf = self;
    [self.networkManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                if ([weakSelf.delegate respondsToSelector:@selector(network:didChaned:)]) {
                    [weakSelf.delegate network:weakSelf didChaned:NetworkTypeUnknow];
                }
                weakSelf.type = NetworkTypeUnknow;
                break;
            case AFNetworkReachabilityStatusNotReachable:
                if ([weakSelf.delegate respondsToSelector:@selector(network:didChaned:)]) {
                    [weakSelf.delegate network:weakSelf didChaned:NetworkTypeNotReachable];
                }
                weakSelf.type = NetworkTypeNotReachable;
            break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                if ([weakSelf.delegate respondsToSelector:@selector(network:didChaned:)]) {
                    [weakSelf.delegate network:weakSelf didChaned:NetworkType3G4G];
                }
                weakSelf.type = NetworkType3G4G;
            break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                if ([weakSelf.delegate respondsToSelector:@selector(network:didChaned:)]) {
                    [weakSelf.delegate network:weakSelf didChaned:NetworkTypeWifi];
                }
                weakSelf.type = NetworkTypeWifi;
            break;
                
            default:
                break;
        }
    }];
    //开始监听
    [self.networkManager startMonitoring];
}

- (NetworkType)getNetWorkType {
    return self.type;
}


@end
