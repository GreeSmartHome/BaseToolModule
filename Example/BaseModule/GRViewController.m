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
#import <UIImageView+Extension.h>

@interface GRViewController ()

@end

@implementation GRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
//    self.view.x
//    @{@"server":[self getServer],@"time":[self getCurrentTime],@"user":@"18163572571",@"psw":@"123456"}
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"time"] = [self getCurrentTime];
//    param[@"user"] = [self getCurrentTime];
//    param[@"psw"] = [self getCurrentTime];
//
//    __weak typeof (self) weaksele = self;
//
//    [[GRNetworkManager shareManager] request:RequestTypeGET urlStr:@"https://grih.gree.com/App/Time" parameter:nil resultBlock:^(id  _Nonnull responseObject, NSError * _Nonnull error) {
//
//        NSLog(@"%@",responseObject);
//    }];
//
//    [[UIImageView new] setURLImageWithURL:nil progress:^(CGFloat progress) {
//
//    } complete:^{
//
//    }];

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
