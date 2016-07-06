//
//  ClipImageViewController.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/5.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry.h>

#import "ClipImageViewController.h"

#define RADIUS ([UIScreen mainScreen].bounds.size.width - 100)

@interface ClipImageViewController ()

@property (nonatomic, strong) UIImageView *bgImgaeView;

@property (nonatomic, strong) UIView *tabBarView;

@property (nonatomic, strong) UIButton *clipBtn;

@property (nonatomic, strong) UIImageView *clipImageView;

@property (nonatomic, strong) UIButton *hideBtn;

@property (nonatomic, strong) UIImage *clipImage;

@end

@implementation ClipImageViewController

- (instancetype)initWithImgae:(UIImage *)image {
    if (self) {
        self.clipImage = image;
        NSData *data = UIImagePNGRepresentation(image);
        NSLog(@"%f  %f    %f",data.length / 1024.0,image.size.width, image.size.height);
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *saveImagePath = [docDir stringByAppendingPathComponent:@"result.png"];
        [data writeToFile:saveImagePath atomically:YES];
        NSLog(@"%@",docDir);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgImgaeView];
    [self.view addSubview:self.tabBarView];
//    [self.tabBarView addSubview:self.hideBtn];
    [self.tabBarView addSubview:self.clipBtn];
    [self.view addSubview:self.clipImageView];
}

- (void)viewWillLayoutSubviews {

    [self.tabBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.left.equalTo(self.view.mas_left).offset(0);
        make.right.equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(44);
    }];
    [self.clipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tabBarView.mas_right).offset(-10);
        make.centerY.equalTo(self.tabBarView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
//    [self.hideBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tabBarView.mas_left).offset(10);
//        make.centerY.equalTo(self.tabBarView.mas_centerY);
//        make.size.mas_equalTo(CGSizeMake(50, 30));
//    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clopAction:(UIButton *)sender {


    self.clipImageView.image = [self getImage];

}

- (void)hideImageViewAction:(UIButton *)seder {
    [self dismissViewControllerAnimated:YES completion:^{

    }];
}

- (UIImage *)getImage {
    CGRect rect = self.view.bounds;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat X = ((rect.size.width - RADIUS) / 2 + 1) * scale;
    CGFloat Y = ((rect.size.height - RADIUS) / 2 + 1) * scale;
    CGFloat clipRadius = (RADIUS -2) *scale ;
    CGRect clipRect = CGRectMake(X, Y, clipRadius, clipRadius);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self.clipImage CGImage], clipRect);
    UIImage *endImage = [UIImage imageWithCGImage:imageRef];
    return endImage;
}

- (void)touchBack {
    [self.navigationController popViewControllerAnimated:YES];
}



- (UIImageView *)bgImgaeView {
    if (_bgImgaeView == nil) {
        _bgImgaeView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _bgImgaeView.contentMode = UIViewContentModeScaleAspectFit;
        _bgImgaeView.image = self.clipImage;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchBack)];
        [_bgImgaeView addGestureRecognizer:tap];
        _bgImgaeView.userInteractionEnabled = YES;
    }
    return _bgImgaeView;
}

- (UIView *)tabBarView {
    if (_tabBarView == nil) {
        _tabBarView = [UIView new];
        _tabBarView.backgroundColor = [UIColor colorWithWhite:1.f alpha:0.9f];
    }
    return _tabBarView;
}

- (UIButton *)clipBtn {
    if (_clipBtn == nil) {
        _clipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _clipBtn.backgroundColor = [UIColor orangeColor];
        [_clipBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_clipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clipBtn addTarget:self action:@selector(clopAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clipBtn;
}

- (UIImageView *)clipImageView {
    if (_clipImageView == nil) {
        _clipImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
        _clipImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _clipImageView;
}

- (UIButton *)hideBtn {
    if (_hideBtn == nil) {
        _hideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _hideBtn.backgroundColor = [UIColor orangeColor];
        [_hideBtn setTitle:@"隐藏" forState:UIControlStateNormal];
        [_hideBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_hideBtn addTarget:self action:@selector(hideImageViewAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hideBtn;
}


@end
