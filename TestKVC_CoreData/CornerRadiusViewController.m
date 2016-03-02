//
//  CornerRadiusViewController.m
//  TestKVC_CoreData
//
//  Created by geng lei on 16/3/2.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry.h>

#import "CornerRadiusViewController.h"
#import "CornerRadiusTableViewCell.h"

@interface CornerRadiusViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *cornerRadiosTableView;

@end

@implementation CornerRadiusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cornerRadiosTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [self.cornerRadiosTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CornerRadiusTableViewCell *cell = [CornerRadiusTableViewCell cellWithTableView:tableView];
    return cell;
}

#pragma mark - Setter Getter

- (UITableView *)cornerRadiosTableView {
    if (_cornerRadiosTableView == nil ) {
        _cornerRadiosTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _cornerRadiosTableView.backgroundColor = [UIColor whiteColor];
        _cornerRadiosTableView.dataSource = self;
        _cornerRadiosTableView.delegate = self;
    }
    return _cornerRadiosTableView;
}

@end
