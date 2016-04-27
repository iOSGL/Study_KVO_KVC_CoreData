//
//  66_AnimationViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/4/26.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry.h>
#import <pop/POP.h>

#import "GJ_AnimationViewController.h"
#import "GJTransitionModel.h"

@interface GJ_AnimationViewController () <UIViewControllerTransitioningDelegate>
/**
 *  事件触发按钮
 */
@property (nonatomic, strong) UIButton *startBtn;
/**
 *  transitnonatomic, ion model
 */
@property (nonatomic, strong) GJTransitionModel *model;

@end

@implementation GJ_AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"66_Animation";
    [self.view addSubview:self.startBtn];
    [self.view addSubview:self.girlImageView];
}

- (void)viewWillLayoutSubviews {
    [self.startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(500);
        make.size.mas_equalTo(CGSizeMake(100, 50));
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIViewControllerTransitioningDelegate

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.model.animationDuration = 0.5;
    self.model.modeType = present;
    return self.model;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.model.animationDuration = 0.5;
    self.model.modeType = dismiss;
    return self.model;
}



#pragma mark - Button Events

- (void)touchAction:(UIButton *)sender {
    GJ_TransitionViewController *control = [[GJ_TransitionViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:control];
    nav.transitioningDelegate = self;
    nav.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:nav animated:YES completion:^{
        
    }];

}

#pragma mark - Setter - Getter

- (UIButton *)startBtn {
    if (_startBtn == nil) {
        _startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn addTarget:self action:@selector(touchAction:) forControlEvents:UIControlEventTouchUpInside];
        [_startBtn setTitle:@"start" forState:UIControlStateNormal];
        [_startBtn setBackgroundColor:[UIColor orangeColor]];
    }
    return _startBtn;
}

- (GJTransitionModel *)model {
    if (_model == nil) {
        _model = [[GJTransitionModel alloc]init];
    }
    return _model;
}

- (UIImageView *)girlImageView {
    if (_girlImageView == nil) {
        _girlImageView = [UIImageView new];
        _girlImageView.image = [UIImage imageNamed:@"girl"];
        CGRect rect = [UIScreen mainScreen].bounds;
        rect.origin.x = (rect.size.width - 110) / 2;
        rect.origin.y = (rect.size.height - 110) / 2;
        rect.size = CGSizeMake(110, 110);
        _girlImageView.frame = rect;
    }
    return _girlImageView;
}

@end
