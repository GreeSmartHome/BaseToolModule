//
//  UIView+Nib.h
//  AFNetworking
//
//  Created by 冉东军 on 2020/2/25.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Nib)

/**
  返回当前xib
 */
+ (instancetype)loadFromNib;

/**
 *  返回当前视图, 所处的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)currentViewController;

@end

NS_ASSUME_NONNULL_END
