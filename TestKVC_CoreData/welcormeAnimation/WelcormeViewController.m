//
//  WelcormeViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/6/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "WelcormeViewController.h"
#import "AnimationView/AnimationView.h"
#import "UIColor+Hex.h"

@interface WelcormeViewController () <AnimatiomViewDelegate>

@property (nonatomic, strong) AnimationView *animationView;

@end

@implementation WelcormeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupAnimation];
   

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark AnimatiomViewDelegate

- (void)completeAnimation {
    [_animationView removeFromSuperview];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#40e0b0"];

        // 2
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Welcome";
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];

    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0);

    } completion:^(BOOL finished) {
        [self addTouchButton];
    }];
}

#pragma mark - Private Method

- (void)setupAnimation {
    CGFloat size = 100.0;
    NSString *className = @"AnimationView";
    NSString *targetName = @"startAnimation";
    Class viewClass = NSClassFromString(className);
    SEL action = NSSelectorFromString(targetName);
    _animationView = [[viewClass alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - size/2, CGRectGetHeight(self.view.frame)/2 - size/2, size, size)];
    _animationView.parentFrame = self.view.bounds;
    _animationView.delegate = self;
    if (_animationView == nil) {
        return;
    }
    if ([_animationView respondsToSelector:action]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_animationView performSelector:action];
        #pragma clang diagnostic pop
    }

    [self.view addSubview:_animationView];
}

- (void)addTouchButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    self.view.backgroundColor = [UIColor whiteColor];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    self.animationView = nil;
    [self setupAnimation];
}

@end
