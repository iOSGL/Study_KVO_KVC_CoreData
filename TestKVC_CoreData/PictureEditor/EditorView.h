//
//  EditorView.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCycleLayer.h"
#import "GRectangleLayer.h"
#import "GshadowLayer.h"

#define RADIUS ([UIScreen mainScreen].bounds.size.width - 100)


@interface EditorView : UIView

@property (nonatomic, strong) UIImageView *zoomImageView;

@property (nonatomic, strong) UIScrollView *zoomScrollView;



/**
 *  init
 *
 *  @param frame       viewFrame
 *  @param type        cycle or rectangle
 *  @param sourceImage clip source image
 *
 *  @return view
 */
- (instancetype)initWithFrame:(CGRect)frame clipType:(ClipType)type zoomImage:(UIImage *)sourceImage;
/**
 *  clip method
 *
 *  @return clip image
 */
-(UIImage *)circularClipImage;
/**
 *  选择不同的截图类型
 *
 *  @param clipType ClipType
 */
- (void)switchTypeWith:(ClipType)clipType;



@end
