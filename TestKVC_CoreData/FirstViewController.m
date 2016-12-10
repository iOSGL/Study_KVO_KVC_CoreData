//
//  FirstViewController.m
//  TestKVC_CoreData
//
//  Created by genglei on 2016/12/9.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "LBTransition.h"

#import <Masonry.h>

@interface FirstViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) LBTransition *transitionModel;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.firstView];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark System Method

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SecondViewController *control = [SecondViewController new];
    control.transitioningDelegate = self;
    control.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:control animated:YES completion:nil];

}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.transitionModel.animationDuration = 0.5;
    self.transitionModel.modeType = present;
    return self.transitionModel;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.transitionModel.animationDuration = 0.35;
    self.transitionModel.modeType = dismiss;
    return self.transitionModel;
}


#pragma mark - Setter Getter 

- (UIView *)firstView {
    if (_firstView == nil) {
        _firstView = [UIView new];
        _firstView.backgroundColor = [UIColor redColor];
        _firstView.frame = CGRectMake(100, 500, 100, 100);
    }
    return _firstView;
}

- (LBTransition *)transitionModel {
    if (_transitionModel == nil) {
        _transitionModel = [LBTransition new];
    }
    return _transitionModel;
}

@end
