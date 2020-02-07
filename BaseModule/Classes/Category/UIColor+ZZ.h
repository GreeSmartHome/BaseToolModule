//
//  UIColor+ZZ.h
//  Knowledge
//
//  Created by 东哥 on 3/9/2019.
//  Copyright © 2019 东哥. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (ZZ)
/**应用主题色*/
+ (UIColor *)colorThemeColor;
//导航栏毛玻璃效果导致的色差  ，假导航用这个上色
+ (UIColor *)newThemeColor;

/**应用辅助色*/
+ (UIColor *)colorAssistColor;
/**应用常用灰*/
+ (UIColor *)colorLightGrayColor;

/**随机色*/
+ (UIColor *)colorWithRandom;
/**16进制色*/
+ (UIColor *)colorWithHexString:(NSString *)colorStr;

/**HUD的背景颜色*/
+(UIColor *)colorHudColor;

/**导航栏颜色*/
+ (UIColor *)colorNavigationBarColor;

/**view背景色*/
+ (UIColor *)colorBackGroundColor;
/**分割线灰*/
+ (UIColor *)colorBoardLineColor;
/**view纯白背景色*/
+ (UIColor *)colorWhiteColor;
/**view偏灰色背景色*/
+(UIColor *)viewBackGroundColor;
/**登录&注册输入框分割线颜色*/
+ (UIColor *)colorLoginRgisterLineColor;


/**深色字体*/
+ (UIColor *)colorDarkTextColor;
/**浅色字*/
+ (UIColor *)colorLightTextColor;
/**渐变*/
+ (CAGradientLayer *)shadowAsInverseWithFrame:(CGRect)frame;


/**
 修改颜色的辅助色
 */
+ (UIColor *)colorTextAssistColor;

/**
 常用按钮字体&背景颜色
 */
+ (UIColor *)totalLabelColor;

/**
 按钮辅助色
 */
+ (UIColor *)colorButtonAssistColor;

@end

NS_ASSUME_NONNULL_END
