//
//  LBTransition.m
//  TestKVC_CoreData
//
//  Created by genglei on 2016/12/9.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import "LBTransition.h"

@implementation LBTransition

#pragma mark -UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.animationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
       if (self.modeType  == present) {
       SecondViewController *toVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
       UINavigationController *fromNav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
       FirstViewController *fromVC = (FirstViewController *)[[fromNav viewControllers]lastObject];
       UIView * containerView = [transitionContext containerView];
        UIView *fromImageView = fromVC.firstView;
        UIView *snpShotView = [fromImageView snapshotViewAfterScreenUpdates:NO];
        snpShotView.frame = [containerView convertRect:fromImageView.frame fromView:fromImageView.superview];
        fromImageView.hidden =YES;
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.alpha = 0;
        toVC.imageView.hidden = YES;
        [containerView addSubview:snpShotView];
        [containerView addSubview:toVC.view];
           
           [UIView animateWithDuration:2 animations:^{
               
               CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
               rotationAnimation.toValue = @(M_PI * 2);
               rotationAnimation.duration = 1;
              
               CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
               scaleAnimation.fromValue = @(0.f);
               scaleAnimation.toValue = @(1.f);
               
               snpShotView.frame = [containerView convertRect:toVC.imageView.frame toView:toVC.imageView.superview];
               CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
               groupAnimation.animations = @[rotationAnimation, scaleAnimation];
               groupAnimation.duration = 2;
               groupAnimation.delegate = self;
               groupAnimation.removedOnCompletion = NO;
               groupAnimation.fillMode = kCAFillModeForwards;
               [snpShotView.layer addAnimation:groupAnimation forKey:@"groupAnimation"];
            
           } completion:^(BOOL finished) {
               [snpShotView removeFromSuperview];
               fromVC.firstView.hidden = NO;
               toVC.imageView.hidden = NO;
                toVC.view.alpha = 1;
               [transitionContext completeTransition:YES];
           }];
           
    } else if (self.modeType == dismiss) {
        UINavigationController *toNav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        FirstViewController *toVC = (FirstViewController *)[[toNav viewControllers]lastObject];
        SecondViewController *fromVC = (SecondViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIView * containerView = [transitionContext containerView];
        UIView *baseView = fromVC.imageView;
        UIView *snpShotView = [baseView snapshotViewAfterScreenUpdates:false];
        snpShotView.frame = [containerView convertRect:baseView.frame fromView:baseView.superview];
        baseView.hidden = YES;
        toVC.view.alpha = 0;
        [containerView addSubview:snpShotView];
        [UIView animateWithDuration:self.animationDuration animations:^{
            snpShotView.frame = [containerView convertRect:toVC.firstView.frame toView:toVC.firstView.superview];
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            [snpShotView removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
    
}

@end
