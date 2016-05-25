//
//  LocalNotificationViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/23.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "LocalNotificationViewController.h"

@interface LocalNotificationViewController ()

@property (nonatomic, strong) UILocalNotification *localNotification;

@end

@implementation LocalNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LocalNotification";
    self.view.backgroundColor = [UIColor whiteColor];
    [self localNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Setter Getter

- (UILocalNotification *)localNotification {
    if (_localNotification == nil) {
        _localNotification = [[UILocalNotification alloc]init];
            // 通知触发时间
        _localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:11];
            // 触发时间所在的时区
        _localNotification.timeZone = [NSTimeZone systemTimeZone];
            // 触发频率
        _localNotification.repeatInterval = NSCalendarUnitMinute;
            // 重复激发所使用的日历
        _localNotification.repeatCalendar = [NSCalendar currentCalendar];
            // 设置角标是否累加
        _localNotification.applicationIconBadgeNumber = 1;
            // 设置通知内容
        _localNotification.alertBody = @"localNotification";
            // 设置标题
        _localNotification.alertTitle = @"本地推送";
            // 设置通知ID 可根据ID 移除对应的通知
        _localNotification.userInfo = @{@"id":@"notification1"};
            // 设置退送声音
        _localNotification.soundName = @"UILocalNotificationDefaultSoundName";
            // Banner  横幅

        [[UIApplication sharedApplication]scheduleLocalNotification:_localNotification];
    }
    return _localNotification;
}

@end
