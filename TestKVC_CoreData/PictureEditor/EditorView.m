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
#import "GshadowLayer.h"

@interface EditorView ()

@property (nonatomic, strong) GCycleLayer *cycleLayer;

@property (nonatomic, strong) GRectangleLayer *rectangleLayer;


@property (nonatomic, strong) GshadowLayer *custormShadowLayer;

@end

@implementation EditorView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadUI];
    }
    return self;
}

#pragma mark - Private Method 

- (void)loadUI {
    [self.layer addSublayer:self.cycleLayer];
    [self.layer addSublayer:self.custormShadowLayer];
}



#pragma mark - Setter Getter

- (GCycleLayer *)cycleLayer {
    if (_cycleLayer == nil) {
        _cycleLayer = [[GCycleLayer alloc]initWithboderWidthColor:[UIColor clearColor] borderWidth:0.5 radius:RADIUS];
    }
    return _cycleLayer;
}

- (GshadowLayer *)custormShadowLayer {
    if (_custormShadowLayer == nil) {
        _custormShadowLayer = [[GshadowLayer alloc]initWithRaidus:RADIUS / 2];
    }
    return _custormShadowLayer;
}

@end
