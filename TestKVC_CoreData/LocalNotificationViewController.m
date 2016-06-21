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

@property (nonatomic, strong) UIButton *startButton;

@property (nonatomic, strong) UIButton *removeButton;



@end

@implementation LocalNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"LocalNotification";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.removeButton];

   


}

- (void)viewWillLayoutSubviews {
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];

    [self.removeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).offset(-200);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
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

#pragma mark - Private Events

- (void)removeCustormLocalNotification {
    UILocalNotification *notifi = [self getCurrentNotification];
    if (notifi) {
     [[UIApplication sharedApplication] cancelLocalNotification:notifi];

    }
}

- (void)actionAddLocalNotification {

    UILocalNotification *currentNotification = [self getCurrentNotification];
    if (currentNotification) {
        [self removeCustormLocalNotification];
        [self localNotification];
    } else {
        [self localNotification];
    }

}

- (UILocalNotification *)getCurrentNotification {
    NSArray *notificationArray = [[UIApplication sharedApplication]scheduledLocalNotifications];
    UILocalNotification *currentNotifi = nil;
    for (UILocalNotification *localNotifi in notificationArray) {
        if ([localNotifi.userInfo[@"id"]isEqualToString:@"notification"]) {
            currentNotifi = localNotifi;
        }
    }
    return currentNotifi;
}

#pragma mark - Button Eevents

- (void)actionStart:(UIButton *)sender {
    [self actionAddLocalNotification];
    sender.selected = YES;
    self.removeButton.selected = NO;
}

- (void)actionRemove:(UIButton *)sender {
    [self removeCustormLocalNotification];
    sender.selected = YES;
    self.startButton.selected = NO;
}


#pragma mark - Setter Getter

- (UILocalNotification *)localNotification {
    if (_localNotification == nil) {
        _localNotification = [[UILocalNotification alloc]init];
            // 通知触发时间
        _localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
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
        _localNotification.userInfo = @{@"id":@"notification"};
            // 设置退送声音
        _localNotification.soundName = @"UILocalNotificationDefaultSoundName";
            // Banner  横幅

        [[UIApplication sharedApplication]scheduleLocalNotification:_localNotification];
    }
    return _localNotification;
}

- (UIButton *)startButton {
    if (_startButton == nil) {
        _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startButton setTitle:@"开始" forState:UIControlStateNormal];
        [_startButton setBackgroundColor:[UIColor purpleColor]];
        [_startButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_startButton addTarget:self action:@selector(actionStart:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startButton;
}

- (UIButton *)removeButton {
    if (_removeButton == nil) {
        _removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_removeButton setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        [_removeButton setBackgroundColor:[UIColor blackColor]];
        [_removeButton addTarget:self action:@selector(actionRemove:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _removeButton;
}

@end
