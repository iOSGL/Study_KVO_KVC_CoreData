//
//  TestThreadViewController.m
//  TestKVC_CoreData
//
//  Created by geng lei on 16/3/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <DateTools.h>
#import <Masonry.h>

#import "TestThreadViewController.h"

@interface TestThreadViewController ()

@end

@implementation TestThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

//    DTTimePeriod *timePeriod = [[DTTimePeriod alloc]initWithStartDate:startDate endDate:endDate];
//    NSLog(@"+++++++++++%f",timePeriod.durationInMinutes);



    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(repeatAction) userInfo:nil repeats:YES];
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop run];
        [timer fire];


    });
    
}


- (void)repeatAction {
    NSLog(@"123456");
}

- (void)touchAction {

//    NSDateFormatter *startFormatter = [[NSDateFormatter alloc]init];
//    [startFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
//
//    NSDate *date = [NSDate date];
//    NSDate *newDate = [date dateByAddingDays:1];
//
//    NSString *dateStr = [newDate formattedDateWithFormat:@"YYYY/MM/dd"];
//    NSString *designationTime = [NSString stringWithFormat:@"%@ 19:00:00",dateStr];
//
//    NSDate *startDate = [startFormatter dateFromString:designationTime];
//
//    NSInteger minutes = arc4random()  % 120;
//
//    startDate = [startDate dateByAddingMinutes:minutes];
//
//    NSLog(@"%@",[startDate formattedDateWithFormat:@"YYYY/MM/dd HH:mm:ss"]);


    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(timer, ^{

        static int number = 0;
        NSLog(@"%d", number);

        if (number == 6) {
            dispatch_source_cancel(timer);
            NSLog(@"Cancle timer.");
        }

    });
    dispatch_resume(timer);

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

@end
