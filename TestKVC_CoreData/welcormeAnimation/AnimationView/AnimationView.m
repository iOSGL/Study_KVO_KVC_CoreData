//
//  AnimationView.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/6/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "AnimationView.h"
#import "CycleLayer.h"
#import "TriangleLayer.h"
#import "RectangleLayer.h"
#import "WaveLayer.h"

@interface AnimationView ()

@property (nonatomic, strong) CycleLayer *cycleLayer;
@property (nonatomic, strong) TriangleLayer *triangleLayer;
@property (nonatomic, strong) RectangleLayer *redRectangleLayer;
@property (nonatomic, strong) RectangleLayer *blueRectangleLayer;
@property (nonatomic, strong) WaveLayer *waveLayer;

@end

@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark - Private Method

- (void)startAnimation {
    [self.layer addSublayer:self.cycleLayer];
    [self.cycleLayer expand];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(wobbleCircleLayer) userInfo:nil repeats:NO];
}

- (void)wobbleCircleLayer {
    [self.cycleLayer wobbleAnimation];
    [self.layer addSublayer:self.triangleLayer];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showTriangleAnimation) userInfo:nil repeats:NO];
}

- (void)showTriangleAnimation {
    [self.triangleLayer triangleAnimate];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(transformAnima) userInfo:nil repeats:NO];
}

- (void)transformAnima {
    [self transformRotationZ];
    [self.cycleLayer contract];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawRedRectangleAnimation) userInfo:nil repeats:NO];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(drawBlueRectangleAnimation) userInfo:nil repeats:NO];
}

- (void)transformRotationZ {
    self.layer.anchorPoint = CGPointMake(0.5, 0.65);
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = @(M_PI * 2);
    rotationAnimation.duration = 0.45;
    rotationAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)drawRedRectangleAnimation {
    [self.layer addSublayer:self.redRectangleLayer];
    [self.redRectangleLayer strokeChangeWithColor:[UIColor colorWithHexString:@"#da70d6"]];
}

- (void)drawBlueRectangleAnimation {
    [self.layer addSublayer:self.blueRectangleLayer];
    [_redRectangleLayer strokeChangeWithColor:[UIColor colorWithHexString:@"#40e0b0"]];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(drawWaveAnimation) userInfo:nil repeats:NO];
}

- (void)drawWaveAnimation {
    [self.layer addSublayer:self.waveLayer];
    [self.waveLayer waveAnimate];
     [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(expandView) userInfo:nil repeats:NO];
}

- (void)expandView {
    self.backgroundColor = [UIColor colorWithHexString:@"#40e0b0"];
    self.frame = CGRectMake(self.frame.origin.x - self.blueRectangleLayer.lineWidth,
                            self.frame.origin.y - self.blueRectangleLayer.lineWidth,
                            self.frame.size.width + self.blueRectangleLayer.lineWidth * 2,
                            self.frame.size.height + self.blueRectangleLayer.lineWidth * 2);
    self.layer.sublayers = nil;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame = self.parentFrame;

    } completion:^(BOOL finished) {
        if (_delegate && [_delegate respondsToSelector:@selector(completeAnimation)]) {
            [_delegate completeAnimation];
        }
    }];
}


#pragma mark - Setter Getter

- (CycleLayer *)cycleLayer {
    if (_cycleLayer == nil) {
        _cycleLayer = [[CycleLayer alloc]init];
    }
    return _cycleLayer;
}

- (TriangleLayer *)triangleLayer {
    if (!_triangleLayer) {
        _triangleLayer = [[TriangleLayer alloc] init];
    }
    return _triangleLayer;
}

- (RectangleLayer *)redRectangleLayer {
    if (!_redRectangleLayer) {
        _redRectangleLayer = [[RectangleLayer alloc] init];
    }
    return _redRectangleLayer;
}

- (RectangleLayer *)blueRectangleLayer {
    if (!_blueRectangleLayer) {
        _blueRectangleLayer = [[RectangleLayer alloc] init];
    }
    return _blueRectangleLayer;
}

- (WaveLayer *)waveLayer {
    if (!_waveLayer) {
        _waveLayer = [[WaveLayer alloc] init];
    }
    return _waveLayer;
}

@end
