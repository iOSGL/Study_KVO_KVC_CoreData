//
//  GJTransitionModel.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/4/26.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "GJ_AnimationViewController.h"
#import "GJ_TransitionViewController.h"


typedef NS_ENUM(NSInteger, transitionMode) {
    present = 1,
    dismiss
};

@interface GJTransitionModel : NSObject <UIViewControllerAnimatedTransitioning>
/**
 *  动画执行时间
 */
@property (nonatomic, assign) CGFloat animationDuration;
/**
 *  动画类型
 */
@property (nonatomic, assign) transitionMode modeType;

@end
