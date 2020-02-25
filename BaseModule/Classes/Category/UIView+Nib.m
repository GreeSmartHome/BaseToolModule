//
//  UIView+Nib.m
//  AFNetworking
//
//  Created by 冉东军 on 2020/2/25.
//

#import "UIView+Nib.h"


@implementation UIView (Nib)
/**
  返回当前xib
 */
+ (instancetype)loadFromNib {
    UIView *view = [[[NSBundle bundleForClass:self] loadNibNamed:NSStringFromClass(self) owner:nil options:0] firstObject];
    return view;
}

/**
 *  返回当前视图, 所处的控制器
 *
 *  @return 控制器
 */
- (UIViewController *)currentViewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
@end
