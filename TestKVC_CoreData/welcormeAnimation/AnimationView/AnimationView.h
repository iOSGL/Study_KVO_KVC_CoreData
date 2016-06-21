//
//  AnimationView.h
//  TestKVC_CoreData
//
//  Created by 66 on 16/6/21.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimatiomViewDelegate <NSObject>

- (void)completeAnimation;

@end

@interface AnimationView : UIView

@property (assign, nonatomic) CGRect parentFrame;

@property (weak, nonatomic) id<AnimatiomViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame;
/**
 *  开始动画
 */
- (void)startAnimation;

@end
