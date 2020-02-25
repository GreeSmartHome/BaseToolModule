//
//  GRUnity.h
//  Gree+
//
//  Created by world hello on 2017/6/2.
//  Copyright © 2017年 gree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRUnity : NSObject


/**
 将16进制转换成颜色
 @param hex 16进制代码
 @return 颜色代码
 */
+ (UIColor*)colorWithRGBHex:(UInt32)hex;

//将16进制转换成颜色,增加透明度 add by deng_hongbin
+ (UIColor*)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha;

/*
 是否为NSArray by 陆愿基
 */

+(BOOL)isValidArray:(NSArray*)array;

/**
是否为NSdictionary by 邓洪斌
 */
+(BOOL)isValidDictionary:(NSDictionary*)dic;


/**
 字符串替换  by 邓洪斌

 @param original 给定的字符串
 @param symbol 要被替换掉的字符串
 @param replaceStr 替换字符串
 @return 字符串
 
 */
+(NSString *) ReplaceFirstNewLine:(NSString * )original symbol:(NSString*)symbol replaceWith:(NSString*)replaceStr;


/**
 检查是否含有子字符串 by 邓洪斌

 @param wholeString 给定的字符串
 @param subString 子字符串
 @return 布尔值
 */
+(BOOL)checkString:(NSString*)wholeString hasSubString:(NSString*)subString;



/**
 得到字节数函数  by 邓洪斌

 @param strtemp 字符串
 @return 字节数
 */
+(int)stringConvertToBytesCount:(NSString*)strtemp;


+(BOOL)strIsEmpty:(NSString *)str;


/**
 判断手机号
 
 @param phone 手机号
 @return bool
 */
+(BOOL)isPhoneNumber:(NSString *)phone;

/**
 验证密码是否至少含有大写、小写字母和数字
 
 @param passwd 密码
 @return bool
 */
+(BOOL)isPasswordRight:(NSString *)passwd;
/**
 验证验证码
 
 @param code 验证码
 @return bool
 */
+(BOOL)isCodeRight:(NSString *)code;

/**
 验证邮箱

 @param email 邮箱
 @return bool
 */
+(BOOL)isEmailRight: (NSString *)email;


/**
 设置纯色背景图片  add by humengliang

 @param color UIColor
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 获取设备应用唯一标识字符串
 */
+(NSString *)getUUID;


/**
 获取设备应用名称
 */
+(NSString *)getAPPName;


/**
 获取应用版本
 */
+ (NSString *)getAppVersion;


/**
 获取手机型号
 */
+ (NSString*)getDeviceVersion;

/**
 获取用户定义的名称
 */
+ (NSString*)getUserPhoneName;


/**
 获取时间
 */
+ (NSString *)getTimeByDate:(NSDate *)date format:(NSString *)format;

/**
 获取时间(date)
 */
+ (NSDate *)getDateByTimeStr:(NSString *)timeStr format:(NSString *)format;

/**
 比如服务器时间2019-04-29 15:08:39,转换至时间2019/04/29
 */
+ (NSString *)getTimeByServerSourceTime:(NSString *)sourceTime desFormat:(NSString *)desFormat;
/**
 转换为服务器时间格式
 */
+ (NSString *)getServerTimeByDate:(NSDate *)date;

/**
 获取当前时间
 */
+ (NSString *)getCurrentTime;


/**
 本地时间转化为UTC时间

 @param localDate 本地时间
 @return UTC时间
 */
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate;

/**
 本地时间转化UTC时间

 @return UTC时间
 */
+ (NSString *)getLastUpdate;


//判断是否空字符
+(BOOL)isBlankString:(NSString *)string;


//获取时间
+(NSString *)getTime;

/**
 UTC时间转换为本地时间
 
 @param utc UTC时间
 @return 本地时间
 */
+ (NSString *)getLocalFromUTC:(NSString *)utc;

//获取文件
+(void)getAllFilesWithDir:(NSString *)dir withArr:(NSMutableArray **)arr;


//获取今天时间字符串
+(NSString *)getToday;

//检查时间格式是否正确
+(BOOL)isTimeFormatCorrect:(NSString *)time;

//检查图片格式是否正确
+(BOOL)isImageFormatCorrect:(NSString *)image;

//检查视频格式是否正确
+(BOOL)isVideoFormatCorrect:(NSString *)video;

//获取本地时间
+(NSString *)getFormateLocalDate;



//AES128加密
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key;

//AES128解密
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key;

//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 字典转化字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

// 设置tableview为grouped时，顶部留白问题
+(void)setTableViewEmptyHeadView:(UITableView *)tableView;

// 设置tableview，使其行数较少不足一屏时不显示空白部分的分隔线
+(void)setTableViewBlank:(UITableView *)tableView;

//获取当前控制器
+(UIViewController *)getCurrentViewController;


@end
