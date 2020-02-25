//
//  GRNetworkManager.h
//  GRNetworkTest
//
//  Created by 冉东军 on 2020/2/23.
//  Copyright © 2020 Gree. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RequestTypeGET,
    RequestTypePOST,
} RequestType;

@interface GRNetworkManager : NSObject

/**
 创建单例
 */
+ (instancetype)shareManager;
/**
  设置请求头文件
 */
- (void)setValue:(NSString *)value forHttpField:(NSString *)field;

/**
  发送请求
 */
- (void)request:(RequestType)requestType urlStr: (NSString *)urlStr parameter: (NSDictionary *)param resultBlock: (void(^)(id responseObject, NSError *error))resultBlock;

@end

NS_ASSUME_NONNULL_END
