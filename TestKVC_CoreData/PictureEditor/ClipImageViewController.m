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

}

- (void)viewWillLayoutSubviews {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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





@end
