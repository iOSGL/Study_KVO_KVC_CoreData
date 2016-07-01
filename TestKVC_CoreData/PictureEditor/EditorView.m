//
//  EditorView.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "EditorView.h"
#import "GCycleLayer.h"
#import "GRectangleLayer.h"

@interface EditorView ()

@property (nonatomic, strong) GCycleLayer *cycleLayer;

@property (nonatomic, strong) GRectangleLayer *rectangleLayer;

@property (nonatomic, strong) CAShapeLayer * maskLayer;

@end

@implementation EditorView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

#pragma mark - Private Method 

- (void)loadUI {
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self.layer addSublayer:self.cycleLayer];
//    [self.layer addSublayer:self.maskLayer];
}

/**
 *  生成空缺部分rect的layer
 */
- (CAShapeLayer *)generateMaskLayerWithRect: (CGRect)rect exceptRect: (CGRect)exceptRect
{
    CAShapeLayer * maskLayer = [CAShapeLayer layer];
    if (!CGRectContainsRect(rect, exceptRect)) {
        return nil;
    }
    else if (CGRectEqualToRect(rect, CGRectZero)) {
        maskLayer.path = [UIBezierPath bezierPathWithRect: rect].CGPath;
        return maskLayer;
    }

    CGFloat boundsInitX = CGRectGetMinX(rect);
    CGFloat boundsInitY = CGRectGetMinY(rect);
    CGFloat boundsWidth = CGRectGetWidth(rect);
    CGFloat boundsHeight = CGRectGetHeight(rect);

    CGFloat minX = CGRectGetMinX(exceptRect);
    CGFloat maxX = CGRectGetMaxX(exceptRect);
    CGFloat minY = CGRectGetMinY(exceptRect);
    CGFloat maxY = CGRectGetMaxY(exceptRect);
    CGFloat width = CGRectGetWidth(exceptRect);

    /** 添加路径*/
    UIBezierPath * path = [UIBezierPath bezierPathWithRect: CGRectMake(boundsInitX, boundsInitY, minX, boundsHeight)];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, boundsInitY, width, minY)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(maxX, boundsInitY, boundsWidth - maxX, boundsHeight)]];
    [path appendPath: [UIBezierPath bezierPathWithRect: CGRectMake(minX, maxY, width, boundsHeight - maxY)]];
    maskLayer.path = path.CGPath;

    return maskLayer;
}



#pragma mark - Setter Getter

- (GCycleLayer *)cycleLayer {
    if (_cycleLayer == nil) {
        _cycleLayer = [[GCycleLayer alloc]initWithboderWidthColor:[UIColor clearColor] borderWidth:0.5 radius:200];
    }
    return _cycleLayer;
}

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer = [self generateMaskLayerWithRect:self.bounds exceptRect:CGRectMake(200, 200, 200, 200)];
    }
    return _maskLayer;
}

@end
