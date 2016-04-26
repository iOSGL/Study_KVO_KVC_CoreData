//
//  66_TransitionViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/4/26.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "GJ_TransitionViewController.h"

@interface GJ_TransitionViewController ()

@end

@implementation GJ_TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"transition";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(touchBack)];
    [self.view addSubview:self.toImageView];
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

#pragma mark - Button Events

- (void)touchBack {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Setter Getter

- (UIImageView *)toImageView {
    if (_toImageView == nil) {
        _toImageView = [UIImageView new];
        _toImageView.image = [UIImage imageNamed:@"timg1"];
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.origin.x = (rect.size.width - 50) / 2;
        rect.origin.y = 50;
        rect.size = CGSizeMake(50, 50);
        _toImageView.frame = rect;
        _toImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _toImageView;
}

@end
