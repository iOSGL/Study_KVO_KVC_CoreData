//
//  GRectangleLayer.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "GRectangleLayer.h"

@interface GRectangleLayer ()

@property (nonatomic , strong) UIBezierPath *bezierPath;

@property (nonatomic, assign) CGSize rectangleSize;

@end

@implementation GRectangleLayer

- (instancetype)initWithfillWidthColor:(UIColor *)color lineWidth:(CGFloat)width withSiz:(CGSize)size {
    self = [super init];
    if (self) {
        self.rectangleSize = size;
        self.fillColor = color.CGColor;
        self.strokeColor = [UIColor whiteColor].CGColor;
        self.lineWidth = width;
        self.path = self.bezierPath.CGPath;
    }
    return self;
}


#pragma mark - Setter Getter 

- (UIBezierPath *)bezierPath {
    if (_bezierPath == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        CGFloat width = self.rectangleSize.width;
        CGFloat height = self.rectangleSize.height;
        CGFloat originX = (rect.size.width - width) / 2;
        CGFloat originY = (rect.size.height - height) / 2;
        _bezierPath = [UIBezierPath bezierPathWithRect:CGRectMake(originX, originY, width, height)];
    }
    return _bezierPath;
}

@end
