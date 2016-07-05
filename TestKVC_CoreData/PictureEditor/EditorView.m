//
//  EditorView.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "EditorView.h"


@interface EditorView () <UIScrollViewDelegate>

@property (nonatomic, strong) GCycleLayer *cycleLayer;

@property (nonatomic, strong) GRectangleLayer *rectangleLayer;

@property (nonatomic, strong) GshadowLayer *custormShadowLayer;

@property (nonatomic, assign) ClipType type;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, assign) CGFloat spaceWidth;

@property (nonatomic, assign) CGFloat spaceHeight;



@end

@implementation EditorView

- (instancetype)initWithFrame:(CGRect)frame clipType:(ClipType)type zoomImage:(UIImage *)sourceImage;
 {
    self = [super initWithFrame:frame];
    if (self) {
        self.spaceWidth = (self.bounds.size.width - 2*RADIUS);
        self.spaceHeight = (self.bounds.size.height - 2*RADIUS);
         self.type = type;
         self.image = sourceImage;
        [self loadUIWith:type];

    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%f   %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
}

- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.zoomImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{

    CGSize boundsSize = scrollView.bounds.size;
    CGRect imgFrame = self.zoomImageView.frame;
    CGSize contentSize = scrollView.contentSize;
    CGPoint centerPoint = CGPointMake(contentSize.width/2, contentSize.height/2);

        // center horizontally
    if (imgFrame.size.width <= boundsSize.width)
        {
        centerPoint.x = boundsSize.width/2;
        }

        // center vertically
    if (imgFrame.size.height <= boundsSize.height)
        {
        centerPoint.y = boundsSize.height/2;
        }


    self.zoomImageView.center = centerPoint;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
}


#pragma mark - Private Method 

- (void)loadUIWith:(ClipType)type {
    [self addSubview:self.zoomScrollView];
    [self.zoomScrollView addSubview:self.zoomImageView];
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

- (CGFloat)getMinimumZoomScale {
    CGFloat miniScale = RADIUS / self.bounds.size.width;
    return miniScale;
}

- (CGFloat)getScreenScale {
    CGFloat screenScale = self.bounds.size.width / RADIUS;
    return screenScale;
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

- (UIScrollView *)zoomScrollView {
    if (_zoomScrollView == nil) {
        CGRect rect = [UIScreen mainScreen].bounds;
        CGFloat width = RADIUS;
        CGFloat height = RADIUS;
        CGFloat originX = (rect.size.width - width) / 2;
        CGFloat originY = (rect.size.height - height) / 2;
        _zoomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(originX, originY, RADIUS, RADIUS)];
        _zoomScrollView.delegate = self;
        [_zoomScrollView setMaximumZoomScale:2.0];
        [_zoomScrollView setMinimumZoomScale:[self getMinimumZoomScale]];
        _zoomScrollView.bouncesZoom = YES;
        _zoomScrollView.zoomScale = 1;
        _zoomScrollView.showsHorizontalScrollIndicator = NO;
        _zoomScrollView.showsVerticalScrollIndicator = NO;
        _zoomScrollView.backgroundColor = [UIColor clearColor];
        _zoomScrollView.clipsToBounds = NO;
        _zoomScrollView.contentOffset = CGPointMake(originX, originY);
    }
    return _zoomScrollView;
}

- (UIImageView *)zoomImageView {
    if (_zoomImageView == nil) {
        _zoomImageView = [UIImageView new];
        _zoomImageView.frame = self.bounds;
        _zoomImageView.contentMode = UIViewContentModeScaleAspectFit;
        _zoomImageView.clipsToBounds = YES;
        _zoomImageView.image = self.image;
        _zoomImageView.userInteractionEnabled = YES;
    }
    return _zoomImageView;
}

@end
