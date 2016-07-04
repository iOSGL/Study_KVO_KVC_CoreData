//
//  GRectangleLayer.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/1.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface GRectangleLayer : CAShapeLayer

- (instancetype)initWithfillWidthColor:(UIColor *)color lineWidth:(CGFloat)width withSiz:(CGSize)size;

@end
