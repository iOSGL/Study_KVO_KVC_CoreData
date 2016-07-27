//
//  StarViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/25.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry.h>

#import "StarViewController.h"
#import "DrawStarView.h"

@interface StarViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UIButton *deleteBtn;

@end

@implementation StarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    DrawStarView *starView = [[DrawStarView alloc]initWithFrame:CGRectMake(50, 100, 200, 30) starSize:20];
    starView.floatOfStars = 3.5;
    [self.view addSubview:starView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.deleteBtn];
    self.dataArray = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"]];
}

- (void)viewWillLayoutSubviews {
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(70);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
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

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Button Events

- (void)deleteAction:(UIButton *)sender {
    [self.dataArray removeObjectAtIndex:1];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
    [self.tableView reloadData];

}

#pragma mark - Setter Getter

- (UITableView *)tableView {
    if (_tableView == nil) {
        CGSize size = [UIScreen mainScreen].bounds.size;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 200, size.width, size.height - 264) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)deleteBtn {
    if (_deleteBtn == nil) {
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [_deleteBtn addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end
