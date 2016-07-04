//
//  GCycleLayer.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "GCycleLayer.h"

@interface GCycleLayer ()

@property (nonatomic, assign) CGFloat radius;

@property (nonatomic, strong) UIBezierPath *cyclePath;

@end

@implementation GCycleLayer

- (instancetype)initWithfillWidthColor:(UIColor *)color lineWidth:(CGFloat)width radius:(CGFloat)radius {
    self = [super init];
    if (self) {
        self.fillColor = color.CGColor;
        self.strokeColor = [UIColor whiteColor].CGColor;
        self.radius = radius;
        self.lineWidth = 2;
        self.path = self.cyclePath.CGPath;
    }
    return self;
}


#pragma mark - Setter Getter

- (UIBezierPath *)cyclePath {
    if (_cyclePath == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        CGFloat originX = (rect.size.width - self.radius) / 2;
        CGFloat originY  = (rect.size.height - self.radius) / 2;
        _cyclePath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(originX, originY, self.radius, self.radius)];
    }
    return _cyclePath;
}

@end
