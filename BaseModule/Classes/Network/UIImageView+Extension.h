//
//  UIImageView+Extension.h
//  AFNetworking
//
//  Created by 冉东军 on 2020/2/25.
//  

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Extension)

/**
  设置图片
 */
- (void)setURLImageWithURL: (NSURL *)url progress:(void(^)(CGFloat progress))progress complete: (void(^)(void))complete;
/**
 设置图片，必须有占位图，是否处理成圆形
*/
- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle;

@end

NS_ASSUME_NONNULL_END
