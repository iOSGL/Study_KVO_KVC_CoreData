
    //
//  GshadowLayer.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/4.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "GshadowLayer.h"

@interface GshadowLayer ()

@property (nonatomic, strong) UIBezierPath *bezierPath;

@property (nonatomic, assign) CGFloat cycleRadius;

@end

@implementation GshadowLayer

- (instancetype)initWithRaidus:(CGFloat)radius {
    self = [super init];
    if (self) {
        self.cycleRadius = radius;
        self.path = self.bezierPath.CGPath;
        self.fillColor = [UIColor colorWithWhite:0.f alpha:0.55f].CGColor;
    }
    return self;
}

#pragma mark - Setter Getter 

- (UIBezierPath *)bezierPath {
    if (_bezierPath == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        _bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
        [_bezierPath appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width / 2, rect.size.height / 2) radius:self.cycleRadius startAngle:0 endAngle:2 * M_PI clockwise:NO]];
    }
    return _bezierPath;
}

@end
