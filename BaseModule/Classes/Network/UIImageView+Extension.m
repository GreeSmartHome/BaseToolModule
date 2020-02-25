//
//  UIImageView+Extension.m
//  AFNetworking
//
//  Created by 冉东军 on 2020/2/25.
//

#import "UIImageView+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIImage+ZZ.h"


@implementation UIImageView (Extension)

/**
  设置图片
 */
- (void)setURLImageWithURL: (NSURL *)url progress:(void(^)(CGFloat progress))progress complete: (void(^)(void))complete {

    [self sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
       
        if (progress != nil) {
            progress(1.0 * receivedSize / expectedSize);
        }
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        self.image = image;
        if (complete != nil) {
            complete();
        }
    }];

}

/**
 设置图片，必须有站位图
*/
- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle {

    if (isCircle) {
        [self sd_setImageWithURL:url placeholderImage:[placeHoldImage circleImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            UIImage *resultImage = [image circleImage];

            // 6. 处理结果图片
            if (resultImage == nil) return;
            self.image = resultImage;
            
        }];

    }else {
        
        [self sd_setImageWithURL:url placeholderImage:placeHoldImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

            // 6. 处理结果图片
            if (image == nil) return;
            self.image = image;
            
        }];

    }


}

@end
