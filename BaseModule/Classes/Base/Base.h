//
//  base.h
//  Pods
//
//  Created by 冉东军 on 2020/2/25.
//

#ifndef Base_h
#define Base_h

// 如果是调试模式(DEBUG 是调试模式下, 自带的宏)
#ifdef DEBUG
#define GRLog(...) NSLog(__VA_ARGS__);
#else
#define GRLog(...)
#endif

// 打印调用函数的宏
#define GRLogFunc GRLog(@"%s",__func__);

// 随机颜色
#define Color(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define GRColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define GRAlphaColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define GRRandomColor GRColor(arc4random_uniform(255.0), arc4random_uniform(255.0), arc4random_uniform(255.0))
#define CommonColor GRColor(223, 223, 223)

// 屏幕尺寸相关
#define ScreenBounds [[UIScreen mainScreen] bounds]
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

// 弱引用
#define WeakSelf __weak typeof(self) weakSelf = self;

/*检查是否空字串*/
#define CHECKSTR(str) (str == nil || [str isKindOfClass:[NSNull class]])? @"" : str

#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

#define iPhoneXTabbarExtraHeight    34

#define GRStatusBar_H (iPhoneX==YES)?44.0f: 20.0f
#define GRNavBar_H ((iPhoneX==YES)?88.0f: 64.0f)
#define GRTabBar_H (iPhoneX==YES)?83.0f: 49.0f

#endif /* base_h */
