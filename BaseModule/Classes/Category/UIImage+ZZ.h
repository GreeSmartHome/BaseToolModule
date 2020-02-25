//
//  UIImage+ZZ.h
//  Knowledge
//
//  Created by 东哥 on 3/9/2019.
//  Copyright © 2019 东哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZZ)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;

- (UIImage *)imageToMax800Image;
- (UIImage *)imageToMaxImage:(CGSize)maxSize;
- (UIImage *)imageToImageMaxHeight:(CGFloat)max;
+ (NSArray *)getBigImageFromImage:(UIImage *)image;
- (UIImage *)imageFixImageViewSize:(CGSize)viewSize;
/// 修改image的大小
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

- (UIImage *)imageToImageMaxWidthOrHeight:(CGFloat)max;
- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
+ (UIImage *)imageFitScreen:(UIImage *)image withSize:(CGSize)size;
+ (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

/// 加载不要被渲染的图片
+ (UIImage *)originImageWithName: (NSString *)name;
///返回圆形图片
- (UIImage *)circleImage;
@end

NS_ASSUME_NONNULL_END
