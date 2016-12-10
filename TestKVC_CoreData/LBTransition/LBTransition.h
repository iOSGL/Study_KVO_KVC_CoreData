//
//  LBTransition.h
//  TestKVC_CoreData
//
//  Created by genglei on 2016/12/9.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FirstViewController.h"
#import "SecondViewController.h"

typedef NS_ENUM(NSInteger, transitionMode) {
    present = 1,
    dismiss
};

@interface LBTransition : NSObject <UIViewControllerAnimatedTransitioning, CAAnimationDelegate>

/**
 *  动画执行时间
 */
@property (nonatomic, assign) CGFloat animationDuration;
/**
 *  动画类型
 */
@property (nonatomic, assign) transitionMode modeType;

@end
