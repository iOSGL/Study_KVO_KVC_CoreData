//
//  GshadowLayer.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/7/4.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface GshadowLayer : CAShapeLayer

typedef NS_ENUM(NSInteger, ClipType) {
    ClipTypeCycle =0,
    ClipTypeRect
};

- (instancetype)initWithRaidus:(CGFloat)radius type:(ClipType)type rectSize:(CGSize)size;

@end
