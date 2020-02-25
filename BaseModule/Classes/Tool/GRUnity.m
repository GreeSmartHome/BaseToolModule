//
//  GRUnity.m
//  Gree+
//
//  Created by world hello on 2017/6/2.
//  Copyright © 2017年 gree. All rights reserved.
//

#import "GRUnity.h"
#import <sys/utsname.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation GRUnity

+ (UIColor*)colorWithRGBHex:(UInt32)hex
{
    int r = (hex >>16) &0xFF;
    int g = (hex >>8) &0xFF;
    int b = (hex) &0xFF;
    return [UIColor colorWithRed:r /255.0f green:g /255.0f blue:b /255.0f alpha:1.0f];
    
}

//将16进制转换成颜色,增加透明度 add by deng_hongbin
+ (UIColor*)colorWithRGBHex:(UInt32)hex alpha:(CGFloat)alpha{
    
    int r = (hex >>16) &0xFF;
    int g = (hex >>8) &0xFF;
    int b = (hex) &0xFF;
    return [UIColor colorWithRed:r /255.0f green:g /255.0f blue:b /255.0f alpha:alpha];


}



#pragma mark /*----------------object/字符串 相关处理-------------*/
//判断是否有效数组
+(BOOL)isValidArray:(NSArray*)array{
    return array != nil && ![array isKindOfClass:[NSNull class]] && array.count != 0;
}

//判断是否是有效字典
+(BOOL)isValidDictionary:(NSDictionary*)dic{
    
    return dic&&[dic isKindOfClass:[NSDictionary class]];
}

//判断字符串是否为空
+(BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}


//字符串替换
+(NSString *) ReplaceFirstNewLine:(NSString * )original symbol:(NSString*)symbol replaceWith:(NSString*)replaceStr{
    
    
    NSMutableString *mstring = [NSMutableString stringWithString:original];
    NSRange wholeShebang = NSMakeRange(0, [mstring length]);
    [mstring replaceOccurrencesOfString: symbol
                             withString: replaceStr
                                options: 0
                                  range: wholeShebang];
    
    return [NSString stringWithString:mstring];
}


//检查子字符串是否存在
+(BOOL)checkString:(NSString*)wholeString hasSubString:(NSString*)subString{
    
    BOOL exist=NO;
    
    if ([wholeString rangeOfString:subString].location != NSNotFound) {
        
        exist= YES;
    }
    
    return exist;
}


+(BOOL)strIsEmpty:(NSString *)str{
    if(!str) {
        return true;
    }else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if([trimedString length] == 0) {
            return true;
        }else {
            return false;
        }
    }
}



/**
 得到字节数函数  by 邓洪斌
 
 @param strtemp 字符串
 @return 字节数
 */
+(int)stringConvertToBytesCount:(NSString*)strtemp{

    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;

}

#pragma mark  设置纯色背景图片
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark 验证手机号的正则
+(BOOL)isPhoneNumber:(NSString *)phone
{
    phone = [phone stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (phone.length != 11){
        return NO;
    }
    NSString *num = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", num];
    BOOL isMatch = [pred evaluateWithObject:phone];
    
    return isMatch;
}

#pragma mark 密码验证
+(BOOL)isPasswordRight:(NSString *)passwd
{
    if (passwd.length < 6 || passwd.length > 20){
        return NO;
    }
    BOOL result ;
    // 判断长度大于6位后再接着判断是否同时包含数字和大小写字母 @"^(?=.*[0-9].*)(?=.*[A-Z].*)(?=.*[a-z].*).{6,20}$"
    NSString * regex = @"^(?=.*[0-9].*)(?=.*[A-Z].*)(?=.*[a-z].*).{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:passwd];
    return result;
    
}
#pragma mark 验证码验证
+(BOOL)isCodeRight:(NSString *)code
{
    if (code.length != 6){
        return NO;
    }
    
    NSString *temp = @"^[0-9]{6}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", temp];
    BOOL isMatch = [pred evaluateWithObject:code];
    
    return isMatch;
}

#pragma mark 邮箱验证
+(BOOL)isEmailRight: (NSString *)email
{
    NSString* emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isMatch = [emailTest evaluateWithObject:email];
    
    return isMatch;
}


//将字符串进行utf8编码
+(NSString *)strToUtf8:(NSString *)str{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";//此处不做更改，
    
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    
    NSString *encodeStr = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodeStr;

}


#pragma mark 获取设备应用唯一标识字符串
/**
 获取设备应用唯一标识字符串
 */
+(NSString *)getUUID
{
    NSString *UUID = [[NSUserDefaults standardUserDefaults] objectForKey:@"GRDeviceUUID"];
    if (!UUID) {
        
        UUID = [[NSUUID UUID] UUIDString];
        [[NSUserDefaults standardUserDefaults] setObject:UUID forKey:@"GRDeviceUUID"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return UUID;
}

#pragma mark 获取应用名称
/**
 获取设备应用名称
 */
+(NSString *)getAPPName
{
    return  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
}

#pragma mark 获取应用版本号
/**
 获取应用版本
 */
+ (NSString *)getAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}


#pragma mark 获取手机型号
/**
 获取手机型号
 */
+ (NSString*)getDeviceVersion
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus";
    
    return deviceString;
}

#pragma mark  获取用户定义的名称
/**
 获取用户定义的名称
 */
+ (NSString*)getUserPhoneName
{
    NSString* userPhoneName = [[UIDevice currentDevice] name];
    return userPhoneName;
}

/**
 获取时间
 */
+ (NSString *)getTimeByDate:(NSDate *)date format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:date];
}

/**
 获取时间(date)
 */
+ (NSDate *)getDateByTimeStr:(NSString *)timeStr format:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter dateFromString:timeStr];
}

/**
 比如服务器时间2019-04-29 15:08:39,转换至时间2019/04/29
 */
+ (NSString *)getTimeByServerSourceTime:(NSString *)sourceTime desFormat:(NSString *)desFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:sourceTime];
    [dateFormatter setDateFormat:desFormat];
    return [dateFormatter stringFromDate:date];
}

/**
 转换为服务器时间格式
 */
+ (NSString *)getServerTimeByDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

/**
 获取当前时间
 */
+ (NSString *)getCurrentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * nowDate = [NSDate date];
    NSString *currentString=[dateFormatter stringFromDate:nowDate];
    return currentString;
    
}
//本地日期转换为UTC
+ (NSString *)getUTCFormateLocalDate:(NSString *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

/**
本地时间转换为UTC时间
 @return 本地时间
 */
+ (NSString *)getLastUpdate
{
    NSString *currentString= [self getCurrentTime];
    currentString = [self getUTCFormateLocalDate:currentString];
    return currentString;
}


/**
 UTC时间转换为本地时间
 
 @param utc UTC时间
 @return 本地时间
 */
+ (NSString *)getLocalFromUTC:(NSString *)utc {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *UTCdate = [dateFormatter dateFromString:utc];
    NSDate *localData =  [self getNowDateFromatAnDate:UTCdate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *UTCString = [dateFormatter stringFromDate:localData];
    return UTCString;
}

+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate {
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}


#pragma mark 获取设备图片
+ (NSString *)getDeviceImageWithMid:(NSString *)mid
{
    NSString *image=@"";
    
    image=[NSString stringWithFormat:@"%@_icon",mid];
    
    return image;
}


//获取时间
+(NSString *)getTime
{
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    format.dateFormat=@"yyyyMMddHHmmss";
    return [format stringFromDate:[NSDate date]];
}


#pragma mark 获取文件
+(void)getAllFilesWithDir:(NSString *)dir withArr:(NSMutableArray **)arr
{
    NSFileManager *manager=[NSFileManager defaultManager];
    BOOL isDir=NO;
    if ([manager fileExistsAtPath:dir isDirectory:&isDir]) {
        if (isDir==YES) {
            NSArray *arrs=[manager contentsOfDirectoryAtPath:dir error:nil];
            for(NSString *temp in arrs){
                NSString *path=[NSString stringWithFormat:@"%@/%@",dir,temp];
                [self getAllFilesWithDir:path withArr:arr];
            }
        }
        else{
            [*arr addObject:dir];
        }
    }
}

//获取今天时间字符串
+(NSString *)getToday
{
    NSDateFormatter *format=[[NSDateFormatter alloc]init];
    format.dateFormat=@"yyyy-MM-dd";
    return [format stringFromDate:[NSDate date]];
}

//检查时间格式是否正确
+(BOOL)isTimeFormatCorrect:(NSString *)time
{
    NSString *temp = @"^[0-9]{4}-[0-9]{2}-[0-9]{2}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", temp];
    BOOL isMatch = [pred evaluateWithObject:time];
    
    return isMatch;
}

//检查图片格式是否正确
+(BOOL)isImageFormatCorrect:(NSString *)image
{
    NSString *temp = @"^[0-9]{14}.jpg$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", temp];
    BOOL isMatch = [pred evaluateWithObject:image];
    
    return isMatch;
}

//检查视频格式是否正确
+(BOOL)isVideoFormatCorrect:(NSString *)video
{
    NSString *temp = @"^[0-9]{14}.mp4$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", temp];
    BOOL isMatch = [pred evaluateWithObject:video];
    
    return isMatch;
}

//获取本地时间
+(NSString *)getFormateLocalDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    return dateString;
}


//AES128加密
+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key {
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    //定义一个字符数组keyPtr
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    // NSString转换成C风格字符串
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    //  对于块加密算法：输出的大小<= 输入的大小 +  一个块的大小
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    // *malloc()*函数其实就在内存中找一片指定大小的空间
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,//工作模式PKCS5Padding：填充方式（IOS中只有PKCS7Padding，别担心，PKCS5Padding是PKCS7Padding的一个子集，所以使用PKCS7Padding代替也是一样的）
                                          keyPtr,//AES的密钥长度有128字节、192字节、256字节几种，这里举出可能存在的最大长度
                                          kCCKeySizeAES128,//密文长度+补位长度
                                          keyPtr,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        // 对加密后的数据进行 base64 编码
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}

//AES128解密
+ (NSString *)AES128Decrypt:(NSString *)encryptText key:(NSString *)key{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:encryptText options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
    }
    free(buffer);
    return nil;
}

//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
// 字典转化字符串
+ (NSString *)convertToJsonData:(NSDictionary *)dict{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

//将UTC日期字符串转为本地时间字符串
//输入的UTC日期格式2013-08-03 04:53:51
+ (NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    
    
    dateFormatted =  [self getNowDateFromatAnDate:dateFormatted];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:localTimeZone];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

// 设置tableview为grouped时，顶部留白问题
+(void)setTableViewEmptyHeadView:(UITableView *)tableView{
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.001)];
}

// 设置tableview，使其行数较少不足一屏时不显示空白部分的分隔线
+(void)setTableViewBlank:(UITableView *)tableView{
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

//获取当前控制器
+(UIViewController *)getCurrentViewController{
    UIViewController *keywindow = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [GRUnity getVisibleViewControllerFrom:keywindow];
}
+(UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc{
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [GRUnity getVisibleViewControllerFrom:((UINavigationController *)vc).visibleViewController];
    }else if ([vc isKindOfClass:[UITabBarController class]]){
        return [GRUnity getVisibleViewControllerFrom:((UITabBarController *)vc).selectedViewController];
    }else{
        if (vc.presentedViewController != nil) {
            return [GRUnity getVisibleViewControllerFrom:vc.presentedViewController];
        }else{
            return vc;
        }
    }
}



@end
