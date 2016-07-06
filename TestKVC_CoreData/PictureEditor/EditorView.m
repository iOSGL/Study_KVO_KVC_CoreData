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

@end

@implementation EditorView

- (instancetype)initWithFrame:(CGRect)frame clipType:(ClipType)type zoomImage:(UIImage *)sourceImage;
 {
    self = [super initWithFrame:frame];
    if (self) {
         self.type = type;
         self.image = sourceImage;
        [self loadUIWith:type];

    }
    return self;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
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

#pragma mark - System Method

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGPoint scrollViewPoint = [self.zoomScrollView convertPoint:point fromView:self];
    if ([self.zoomScrollView pointInside:scrollViewPoint withEvent:event]) {
        return self.zoomScrollView;
    }
    return self.zoomScrollView;
}

#pragma mark - Open Method 

-(UIImage *)circularClipImage {
    UIImage *image = nil;
    if (self.type == ClipTypeCycle) {
        image = [self getImage:self.zoomImageView.image];
        image = [self circleImage:image withParam:2];
    } else if (self.type == ClipTypeRect) {
        image =[self getImage:self.zoomImageView.image];
    }
    return image;
}

- (void)switchTypeWith:(ClipType)clipType {
    self.type = clipType;
}

#pragma mark - Private Method 

-(UIImage *)circularClipImage:(UIImage *)image withType:(ClipType)clipType {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGRect rect = self.bounds;
    CGFloat X = (rect.size.width - RADIUS) / 2 + 1;
    CGFloat Y = (rect.size.height - RADIUS) / 2 + 1;
    CGFloat clipRadius = RADIUS -2 ;
    CGRect clipRect = CGRectMake(X, Y, clipRadius, clipRadius);
    UIGraphicsBeginImageContext(newImage.size);
    UIBezierPath *path = nil;
    if (clipType == ClipTypeCycle) {
        path = [UIBezierPath bezierPathWithOvalInRect:clipRect];
    } else if (clipType == ClipTypeRect) {
        path = [UIBezierPath bezierPathWithRect:clipRect];
    } else {
    }
    [path addClip];
    [newImage drawAtPoint:CGPointZero];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  clipImage;

}

- (UIImage *)getImage:(UIImage *)image {
        // 对keyWindow截图
    UIView *window = [UIApplication sharedApplication].keyWindow;
    CGSize viewSize = window.bounds.size;
    UIGraphicsBeginImageContextWithOptions(viewSize, YES, [UIScreen mainScreen].scale);
    [window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    CGFloat scale = [UIScreen mainScreen].scale;
    CGRect rect = CGRectMake(0, 0, shotImage.size.width, shotImage.size.height);
    CGFloat X = (rect.size.width - RADIUS)/2*scale;
    CGFloat Y = (rect.size.height - RADIUS)/2*scale;
    CGRect clipRect = CGRectMake(X, Y, RADIUS*scale, RADIUS*scale);

    CGImageRef avatarImageRef = CGImageCreateWithImageInRect([shotImage CGImage], clipRect);
    UIImage *avatarImage = [UIImage imageWithCGImage:avatarImageRef];
    CGImageRelease(avatarImageRef);
    return avatarImage;
}

-(UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset {
     UIGraphicsBeginImageContext(image.size);
     CGContextRef context = UIGraphicsGetCurrentContext();
//     CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
     CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
     CGContextAddEllipseInRect(context, rect);
     CGContextClip(context);
     [image drawInRect:rect];
     CGContextAddEllipseInRect(context, rect);
//     CGContextStrokePath(context);
     UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
    return newimg;
}

-(UIImage *)scaleToSize:(UIImage *)image size:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *endImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return endImage;
}

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
        CGRect rect = self.bounds;
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
