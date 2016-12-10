//
//  SecondViewController.m
//  TestKVC_CoreData
//
//  Created by genglei on 2016/12/9.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry.h>

@interface SecondViewController ()



@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.imageView];
     self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - System Method 

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setter Getter 

- (UIView *)imageView {
    if (_imageView == nil) {
        _imageView = [UIView new];
        _imageView.backgroundColor = [UIColor yellowColor];
        _imageView.frame = CGRectMake(40, 64, 200, 200);
    }
    return _imageView;
}

@end
