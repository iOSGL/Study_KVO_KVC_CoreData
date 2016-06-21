//
//  RectangleLayer.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/6/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "UIColor+Hex.h"

@interface RectangleLayer : CAShapeLayer

/**
 *  Change line stroke color with custon color
 *
 *  @param color custom color
 */
- (void)strokeChangeWithColor:(UIColor *)color;

@end
