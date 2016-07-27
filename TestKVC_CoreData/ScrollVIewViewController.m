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

@interface ScrollVIewViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) firstScrollView *firstView;

@property (nonatomic, strong) SecondScrollView *secondView;

@property (nonatomic, strong) UIScrollView *testScrollView;

@property (nonatomic, strong) UITableView *commentTableView;

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation ScrollVIewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"custorm ScrollView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.firstView];
    NSMutableArray *testArray = [NSMutableArray new];
    for (NSInteger i = 0; i < 100; i++) {
        [testArray addObject:[NSString stringWithFormat:@"%zi",i]];
    }
    self.dataArray = [testArray copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

#pragma mark - System Method 

#pragma mark Private Method


- (void)configFirstScrollView {
    CGRect rect = self.testScrollView.bounds;
    for (NSInteger i = 0; i < 2; i ++) {
        UIView *content = [[UIView alloc]init];
        rect.origin.y = i * self.view.frame.size.height;
        content.frame = rect;
        if (i == 0) {
            content.backgroundColor = [UIColor orangeColor];
        }else {
            content.backgroundColor = [UIColor blueColor];
        }
        [self.testScrollView addSubview:content];
    }
    [self.testScrollView setContentSize:CGSizeMake(self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height * 2)];
}


#pragma mark - Setter Getter

- (firstScrollView *)firstView {
    if (_firstView == nil) {
        [self configFirstScrollView];
        _firstView = [[firstScrollView alloc]initWithFrame:CGRectMake(0, 64, MAIN_BOUNDS_WIDTH, MAIN_BOUNDS_HEIGHT - 64) linkAgeWithScrollView:self.testScrollView commentScrollView:self.commentTableView];
    }
    return _firstView;
}

- (SecondScrollView *)secondView {
    if (_secondView == nil) {
        _secondView = [[SecondScrollView alloc]initWithFrame:CGRectMake(0, 0, MAIN_BOUNDS_WIDTH, MAIN_BOUNDS_HEIGHT)];
    }
    return _secondView;
}

- (UIScrollView *)testScrollView {
    if (_testScrollView == nil) {
        _testScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MAIN_BOUNDS_WIDTH, MAIN_BOUNDS_HEIGHT)];
        self.testScrollView.backgroundColor = [UIColor clearColor];

    }
    return _testScrollView;
}

- (UITableView *)commentTableView {
    if (_commentTableView == nil) {
        _commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MAIN_BOUNDS_WIDTH, MAIN_BOUNDS_HEIGHT) style:UITableViewStylePlain];
        _commentTableView.backgroundColor = [UIColor clearColor];
        _commentTableView.dataSource = self;
        _commentTableView.delegate = self;
        _commentTableView.contentInset = UIEdgeInsetsMake(MAIN_BOUNDS_HEIGHT, 0, 0, 0);
    }
    return _commentTableView;
}




@end
