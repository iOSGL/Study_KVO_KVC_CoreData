//
//  66_TransitionViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/4/26.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <YYImage.h>
#import <YYCategories.h>

#import "GJ_TransitionViewController.h"

#define MAIN_BOUNDS [UIScreen mainScreen].bounds;

@interface GJ_TransitionViewController ()
/**
 *  测试view
 */
@property (nonatomic, strong) UIView *transitionView;
/**
 *  背景Image
 */
@property (nonatomic, strong) UIImageView *backGroundImage;



@end

@implementation GJ_TransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"transition";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(touchBack)];
    [self.view addSubview:self.backGroundImage];
    [UIView animateWithDuration:0.3 animations:^{
        self.backGroundImage.alpha = 1;
    }];
    [self.view addSubview:self.toImageView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
         [self.view addSubview:self.transitionView];
        
        [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:15 initialSpringVelocity:0 options:UIViewAnimationOptionTransitionNone animations:^{
            CGRect rect = MAIN_BOUNDS;
            rect.origin.y = 200;
            rect.size.height = rect.size.height - 200;
            self.transitionView.frame = rect;
        } completion:^(BOOL finished) {
            
        }];
    });
   
    
}

- (void)viewWillLayoutSubviews {
    
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
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.origin.x = (rect.size.width - 55) / 2;
        rect.origin.y = 100;
        rect.size = CGSizeMake(55, 55);
        _toImageView.frame = rect;
        _toImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _toImageView;
}

- (UIImage *)girlImage {
    if (_girlImage == nil) {
        _girlImage = [UIImage imageNamed:@"girl"];
    }
    return _girlImage;
}

- (UIView *)transitionView {
    if (_transitionView == nil) {
        _transitionView = [UIView new];
        _transitionView.backgroundColor = [UIColor orangeColor];
        CGRect rect = MAIN_BOUNDS;
        rect.origin.y = (rect.size.height - 200) / 2;
        rect.origin.x = rect.size.width / 2;
        rect.size = CGSizeMake(0, 0);
        _transitionView.frame = rect;
    }
    return _transitionView;
}

- (UIImageView *)backGroundImage {
    if (_backGroundImage == nil) {
        _backGroundImage = [UIImageView new];
        _backGroundImage.image = [[UIImage imageNamed:@"girl"] imageByBlurDark];
        CGRect rect = MAIN_BOUNDS;
        rect.size.height = 200;
        _backGroundImage.alpha = 0;
        _backGroundImage.frame = rect;
        
    }
    return _backGroundImage;
}

@end
