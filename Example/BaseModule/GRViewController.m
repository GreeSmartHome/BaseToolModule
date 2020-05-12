//
//  GRViewController.m
//  BaseModule
//
//  Created by 1049646716@qq.com on 02/07/2020.
//  Copyright (c) 2020 1049646716@qq.com. All rights reserved.
//

#import "GRViewController.h"
#import <UIView+ZZ.h>
#import <GRNetworkManager.h>
#import <GRRequestManager.h>
#import <UIImageView+Extension.h>

@interface GRViewController ()

@end

@implementation GRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	 NSString *url = @"https://grih.gree.com/App/GetFeaturedOrTipsList";
   NSMutableDictionary *param = [NSMutableDictionary dictionary];
   param[@"type"] = @(0);
   param[@"index"] = @(1);
   param[@"cnt"] = @(10);
   
   NSMutableString *arguments = [NSMutableString string];
   [arguments appendString:[NSString stringWithFormat:@"?type=%@", @(0)]];
   [arguments appendString:[NSString stringWithFormat:@"&index=%@&cnt=%@", @(1), @(10)]];
   
   NSString *urlStr = [NSString stringWithFormat:@"%@%@",url,arguments];
   
   [[GRRequestManager shareManager] request:RequestTypeGET urlStr:urlStr parameter:param resultBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
       
       if (!error) {
           NSDictionary *result = (NSDictionary *)responseObject;
          NSDictionary *result2 =  [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
           NSLog(@"====%@",result);
       }
       
   }];
    
    

    NSInteger ty = [[GRNetworkManager shareManager] getNetWorkType];
    if (ty == NetworkTypeWifi) {
         NSLog(@"网络环境WiFi");
    }
   
    
}
-(NSString *)getCurrentTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //UTC时间
    NSDate *date = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    //输出格式
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
