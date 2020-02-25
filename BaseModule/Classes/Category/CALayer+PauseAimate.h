//
//  CALayer+PauseAimate.h
//  AFNetworking
//
//  Created by 冉东军 on 2020/2/25.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (PauseAimate)

// 暂停动画
- (void)pauseAnimate;

// 恢复动画
- (void)resumeAnimate;

@end

NS_ASSUME_NONNULL_END
