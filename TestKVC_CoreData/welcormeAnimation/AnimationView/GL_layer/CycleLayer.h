//
//  CycleLayer.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/6/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CycleLayer : CAShapeLayer
/**
 *  Expend animation for circle layer
 */
- (void)expand;
/**
 *  Wobble group animation
 */
- (void)wobbleAnimation;
/**
 *  Contract animation for circle layer
 */
- (void)contract;

@end
