//
//  CoreAnimationViewController.m
//  TestKVC_CoreData
//
//  Created by geng lei on 16/3/11.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <QuartzCore/QuartzCore.h>

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()

@property (nonatomic, strong) UIView *layerView;

@property (nonatomic, strong) CALayer *blueLayer;

@property (nonatomic, strong) CALayer *colorLayer;

@property (nonatomic, strong) UIButton *touchActionBtn;

@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Core Animation";
    [self.view addSubview:self.layerView];
    [self.view addSubview:self.touchActionBtn];
    [self clearAnimation];
//    [self baseAnimation];
//    UIImage *chestImage = [UIImage imageNamed:@"girl"];
//    [self.layerView.layer addSublayer:self.blueLayer];
//    self.layerView.layer.contents = (__bridge id)chestImage.CGImage;
//    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;
//    self.layerView.layer.contentsRect = CGRectMake(0, 0, 1, 1);
//    self.layerView.layer.shadowOpacity = 0.5;
//    // 阴影
//    CGMutablePathRef circlePath = CGPathCreateMutable();
//    CGPathAddEllipseInRect(circlePath, NULL, self.layerView.bounds);
//    self.layerView.layer.shadowPath = circlePath; CGPathRelease(circlePath);
//    
////    CGAffineTransform transform = CGAffineTransformMakeRotation(M_PI_4);
////    self.layerView.layer.affineTransform = transform;
////    CGAffineTransform transform = CGAffineTransformIdentity;
////    transform = CGAffineTransformScale(transform, 0.1, 0.1);
////    transform = CGAffineTransformRotate(transform, M_PI / 180.0 * 30.0);
//////    transform = CGAffineTransformTranslate(transform, 200, 0);
////   [UIView animateWithDuration:1 animations:^{
////       self.layerView.layer.affineTransform = transform;
////   } completion:^(BOOL finished) {
////       self.layerView.hidden = YES;
////   }];
//    
//    CATransform3D transform3D = CATransform3DIdentity;
//     transform3D.m34 = - 1.0 / 500.0;
//    transform3D = CATransform3DRotate(transform3D, M_PI_4, 0, 1, 0);
//    self.layerView.layer.transform = transform3D;
//    
//    [self shapLayer];
    
    
    
}

- (void)viewWillLayoutSubviews {
    [self.layerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    [self.touchActionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).with.offset(60);
        make.size.mas_equalTo(CGSizeMake(100, 60));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Example
// 隐式动画
- (void)baseAnimation {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 200, 200);
    self.colorLayer.backgroundColor = [UIColor orangeColor].CGColor;
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    self.colorLayer.actions = @{@"backgroundColor":transition};
    [self.layerView.layer addSublayer:self.colorLayer];
}

- (void)clearAnimation {
    self.colorLayer = [CALayer layer];
    self.colorLayer.frame = CGRectMake(0, 0, 200, 200);
    self.colorLayer.backgroundColor = [UIColor orangeColor].CGColor;
    [self.layerView.layer addSublayer:self.colorLayer];
}

#pragma mark - Button Event

- (void)touchToDo:(UIButton *)sender {
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:2];
////    [CATransaction setCompletionBlock:^{
////        CGAffineTransform transform = self.colorLayer.affineTransform;
////        transform = CGAffineTransformRotate(transform, M_PI_2);
////        self.colorLayer.affineTransform = transform;
////    }];
    CGFloat red = arc4random() / (CGFloat)INT_MAX;
    CGFloat green = arc4random() / (CGFloat)INT_MAX;
    CGFloat blue = arc4random() / (CGFloat)INT_MAX;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"backgroundColor";
    animation.toValue = (__bridge id)color.CGColor;
    animation.delegate = self;
    
    [self.colorLayer addAnimation:animation forKey:nil];
//    self.colorLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
//    [CATransaction commit];
    
}

- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.colorLayer.backgroundColor = (__bridge CGColorRef)anim.toValue;
    [CATransaction commit];
}

#pragma mark - Private Method

- (void)shapLayer {
    
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(175, 100)];
//    
//    [path addArcWithCenter:CGPointMake(150, 100) radius:25 startAngle:0 endAngle:2*M_PI clockwise:YES];
//    [path moveToPoint:CGPointMake(150, 125)];
//    [path addLineToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(125, 225)];
//    [path moveToPoint:CGPointMake(150, 175)];
//    [path addLineToPoint:CGPointMake(175, 225)];
//    [path moveToPoint:CGPointMake(100, 150)];
//    [path addLineToPoint:CGPointMake(200, 150)];
    
    CGRect rect = CGRectMake(50, 50, 100, 100);
    CGSize radii = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    //add it to our view
    [self.layerView.layer addSublayer:shapeLayer];
}

#pragma mark - Setter - Getter

- (UIView *)layerView {
    if (_layerView == nil) {
        _layerView = [UIView new];
        _layerView.backgroundColor = [UIColor grayColor];
    }
    return _layerView;
}

- (CALayer *)blueLayer {
    if (_blueLayer == nil) {
        _blueLayer = [CALayer layer];
        _blueLayer.backgroundColor = [UIColor blueColor].CGColor;
        _blueLayer.frame = CGRectMake(50.0f, 50.0f, 100.0f, 100.0f);
        _blueLayer.anchorPoint = CGPointMake(1, 0.5);
    }
    return _blueLayer;
}

- (UIButton *)touchActionBtn {
    if (_touchActionBtn == nil) {
        _touchActionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_touchActionBtn setTitle:@"点击按钮" forState:UIControlStateNormal];
        [_touchActionBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_touchActionBtn addTarget:self action:@selector(touchToDo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touchActionBtn;
}



@end
