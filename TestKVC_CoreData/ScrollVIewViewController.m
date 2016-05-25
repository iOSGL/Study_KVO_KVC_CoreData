//
//  ScrollVIewViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/5/24.
//  Copyright © 2016年 genglei. All rights reserved.
//
#import <pop/POP.h>

#import "ScrollVIewViewController.h"
#import "firstScrollView.h"
#import "SecondScrollView.h"

#define MAIN_BOUNDS_WIDTH [UIScreen mainScreen].bounds.size.width

#define MAIN_BOUNDS_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ScrollVIewViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) firstScrollView *firstView;

@property (nonatomic, strong) SecondScrollView *secondView;

@end

@implementation ScrollVIewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"custorm ScrollView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.firstView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - System Method 

#pragma mark Private Method

#pragma mark - Setter Getter

- (firstScrollView *)firstView {
    if (_firstView == nil) {
        _firstView = [[firstScrollView alloc]initWithFrame:CGRectMake(0, 0, MAIN_BOUNDS_WIDTH, MAIN_BOUNDS_HEIGHT)];
    }
    return _firstView;
}

- (SecondScrollView *)secondView {
    if (_secondView == nil) {
        _secondView = [[SecondScrollView alloc]initWithFrame:CGRectMake(0, 0, MAIN_BOUNDS_WIDTH, MAIN_BOUNDS_HEIGHT)];
    }
    return _secondView;
}




@end
