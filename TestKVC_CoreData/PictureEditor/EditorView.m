//
//  EditorView.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "EditorView.h"


@interface EditorView ()

@property (nonatomic, strong) GCycleLayer *cycleLayer;

@property (nonatomic, strong) GRectangleLayer *rectangleLayer;

@property (nonatomic, strong) GshadowLayer *custormShadowLayer;

@property (nonatomic, assign) ClipType type;

@end

@implementation EditorView

- (instancetype)initWithFrame:(CGRect)frame clipType:(ClipType)type;
 {
    self = [super initWithFrame:frame];
    if (self) {
         self.type = type;
        [self loadUIWith:type];
    }
    return self;
}

#pragma mark - Private Method 

- (void)loadUIWith:(ClipType)type {
    switch (type) {
        case ClipTypeCycle: {
            [self.layer addSublayer:self.cycleLayer];
        }
            break;
        case ClipTypeRect: {
            [self.layer addSublayer:self.rectangleLayer];
        }
            break;

        default:
            break;
    }
    [self.layer addSublayer:self.custormShadowLayer];
}

#pragma mark - Setter Getter

- (GCycleLayer *)cycleLayer {
    if (_cycleLayer == nil) {
        _cycleLayer = [[GCycleLayer alloc]initWithfillWidthColor:[UIColor clearColor] lineWidth:2 radius:RADIUS];
    }
    return _cycleLayer;
}

- (GshadowLayer *)custormShadowLayer {
    if (_custormShadowLayer == nil) {
        _custormShadowLayer = [[GshadowLayer alloc]initWithRaidus:RADIUS / 2 type:self.type rectSize:CGSizeMake(RADIUS, RADIUS)];
    }
    return _custormShadowLayer;
}

- (GRectangleLayer *)rectangleLayer {
    if (_rectangleLayer == nil) {
        _rectangleLayer = [[GRectangleLayer alloc]initWithfillWidthColor:[UIColor clearColor] lineWidth:2 withSiz:CGSizeMake(RADIUS, RADIUS)];
    }
    return _rectangleLayer;
}

@end
