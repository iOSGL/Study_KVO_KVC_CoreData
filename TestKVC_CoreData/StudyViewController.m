//
//  StudyViewController.m
//  TestKVC_CoreData
//
//  Created by genglei on 16/2/28.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "StudyViewController.h"

@interface StudyViewController ()

@property (nonatomic, strong) UIView *layerView;

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.layerView];
}

- (void)viewWillLayoutSubviews {
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view.mas_centerY);
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(200, 200));
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

#pragma mark - Setter Getter 

- (UIView *)layerView {
    if (_layerView == nil) {
        _layerView = [UIView new];
        _layerView.backgroundColor = [UIColor orangeColor];
        _layerView.layer.cornerRadius = 5.0f;
        _layerView.layer.borderWidth =  1.0f;
        _layerView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _layerView;
}

@end
