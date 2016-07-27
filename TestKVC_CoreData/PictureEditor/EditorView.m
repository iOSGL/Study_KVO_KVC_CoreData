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
        image = [self autoImage:image size:image.size];
    } else if (self.type == ClipTypeRect) {
        image =[self getImage:self.zoomImageView.image];
    }
    return image;
}

- (void)switchTypeWith:(ClipType)clipType {
    self.type = clipType;
}

#pragma mark - Private Method 

/**
 *  用贝塞尔曲线 获得 矩形图 和 圆
 *  缺点是 [newImage drawAtPoint:CGPointZero]; 从屏幕左上角开始绘制，得到的图片的分辨率与手机分辨率一致。
 *
 *  @param image    source image
 *  @param clipType type
 *
 *  @return image
 */

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

/**
 *  截取矩形图片
 *
 *  @param image source image
 *
 *  @return image
 */

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
    CGFloat X = (rect.size.width - RADIUS)/2*scale + 1;
    CGFloat Y = (rect.size.height - RADIUS)/2*scale + 1;
    CGRect clipRect = CGRectMake(X, Y, RADIUS*scale - 2, RADIUS*scale - 2);

    CGImageRef avatarImageRef = CGImageCreateWithImageInRect([shotImage CGImage], clipRect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(avatarImageRef), CGImageGetHeight(avatarImageRef));
    UIGraphicsBeginImageContextWithOptions(smallBounds.size,NO,scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, avatarImageRef);
    UIImage *smallImage = [UIImage imageWithCGImage:avatarImageRef];
    CGImageRelease(avatarImageRef);
    UIGraphicsEndImageContext();

    return smallImage;
}

/**
 *  为矩形图片添加边框。 做成头像 效果
 *
 *  @param image source image
 *  @param inset 椭圆
 *
 *  @return image
 */

-(UIImage*)circleImage:(UIImage*)image withParam:(CGFloat)inset {
     UIGraphicsBeginImageContext(image.size);
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
     CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
     CGContextAddEllipseInRect(context, rect);
     CGContextClip(context);
     [image drawInRect:rect];
     CGContextAddEllipseInRect(context, rect);
     CGContextStrokePath(context);
     UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
    return newimg;
}
/**
 *  切割矩形图片为圆形图片
 *
 *  @param image source image
 *
 *  @return image
 */
-(UIImage *)circularClipImage:(UIImage *)image {
        /*
    CGFloat arcCenterX = image.size.width/ 2;
    CGFloat arcCenterY = image.size.height / 2;
    CGFloat scale = [UIScreen mainScreen].scale;

    UIGraphicsBeginImageContext(image.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, arcCenterX * scale, arcCenterY * scale)];
    [path addClip];
    [image drawAtPoint:CGPointMake(20, 10)];
    UIImage *clipImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  clipImage;
         */
    CGFloat arcCenterX = image.size.width/ 2;
    CGFloat arcCenterY = image.size.height / 2;

    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddArc(context, arcCenterX , arcCenterY, image.size.width/ 2 - 2, 0.0, 2*M_PI, NO);
    CGContextClip(context);
    CGRect myRect = CGRectMake(0 , 0, image.size.width ,  image.size.height);
    [image drawInRect:myRect];

    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  newImage;
}

-(UIImage*)circleImage:(UIImage*)image
{
    CGFloat inset = 0.1f;
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f, image.size.height - inset * 2.0f);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);

    [image drawInRect:rect];
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

-(UIImage*)autoImage:(UIImage*)image size:(CGSize)theSize
{
    if (image == nil)
        {
            return nil;
        }
    CGSize imgSize = image.size;
    if (imgSize.height == 0 || imgSize.width == 0 || theSize.width == 0 || theSize.height == 0)
        {
            return nil;
        }
    CGFloat nx = 0.0f;
    CGFloat ny = 0.0f;
    CGFloat nw = 0.0f;
    CGFloat nh = 0.0f;
    UIImage *autoImg = image;
    if (imgSize.width/imgSize.height >= theSize.width/theSize.height)
        {
            autoImg = [self changeImageSizeWithOriginalImage:image percent:theSize.height/imgSize.height];

            nw = theSize.width;
            nh = autoImg.size.height;
            ny = 0;
            nx = ABS(autoImg.size.width -  theSize.width)/2;

        }
    else
        {
            autoImg = [self changeImageSizeWithOriginalImage:image percent:theSize.width/imgSize.width];
            nh = theSize.height;
            nw = autoImg.size.width;
            nx = 0;
            ny = ABS(autoImg.size.height -  theSize.height)/2;
        }


    CGRect rect = CGRectMake(nx, ny, nw, nh);
    CGImageRef subImageRef = CGImageCreateWithImageInRect(autoImg.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));

    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);  
    return smallImage;  
    
}

-(UIImage*)changeImageSizeWithOriginalImage:(UIImage*)image percent:(float)percent
{
        // change the image size
    UIImage *changedImage=nil;
    float iwidth=image.size.width*percent;
    float iheight=image.size.height*percent;
    if (image.size.width != iwidth && image.size.height != iheight)
        {
            CGSize itemSize = CGSizeMake(iwidth, iheight);
            UIGraphicsBeginImageContext(itemSize);
            CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
            [image drawInRect:imageRect];
            changedImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
        }
    else
        {
            changedImage = image;
        }
    
    return changedImage;  
}

/**
 *  改变图像尺寸
 *
 *  @param image source image
 *  @param size  size
 *
 *  @return image
 */
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
