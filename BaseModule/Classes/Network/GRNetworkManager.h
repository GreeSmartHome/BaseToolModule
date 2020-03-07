//
//  GRNetworkManager.h
//  GRNetworkTest
//
//  Created by 冉东军 on 2020/2/23.
//  Copyright © 2020 Gree. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,NetworkType){
    NetworkType3G4G,
    NetworkTypeWifi,
    NetworkTypeUnknow,
    NetworkTypeNotReachable,
};
@class GRNetworkManager;
@protocol GRNetworkManagerDelegate <NSObject>

- (void)network:(GRNetworkManager *)network didChaned:(NetworkType)networkType;

@end

@interface GRNetworkManager : NSObject

@property (nonatomic ,weak) id <GRNetworkManagerDelegate> delegate;
/**
 创建单例
 */
+ (instancetype)shareManager;

/**
 检测网络环境
 */
- (NetworkType)getNetWorkType;

@end

NS_ASSUME_NONNULL_END
