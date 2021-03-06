//
//  GRRequestManager.h
//  AFNetworking
//
//  Created by 东哥 on 7/3/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    RequestTypeGET,
    RequestTypePOST,
} RequestType;


@interface GRRequestManager : NSObject

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
