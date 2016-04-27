//
//  GJTransitionModel.m
//  TestKVC_CoreData
//
//  Created by 66 on 16/4/26.
//  Copyright © 2016年 genglei. All rights reserved.
//

#import <pop/POP.h>
#import <pop/POPLayerExtras.h>

#import "GJTransitionModel.h"

@implementation GJTransitionModel

#pragma mark -UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return self.animationDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    if (self.modeType == present) {
        UINavigationController *fromNav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        GJ_AnimationViewController *fromVC = (GJ_AnimationViewController *)[[fromNav viewControllers]lastObject];
        UINavigationController *toNav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        GJ_TransitionViewController *toVC = (GJ_TransitionViewController *)[[toNav viewControllers] firstObject];
        UIView *containerView = [transitionContext containerView];
        UIImageView *baseImage = fromVC.girlImageView;
        UIView *snapShotView = [baseImage snapshotViewAfterScreenUpdates:NO];
        snapShotView.frame = [containerView convertRect:baseImage.frame fromView:baseImage.superview];
        baseImage.hidden = YES;
        
        toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
        toVC.view.alpha = 0;
        
        [containerView addSubview:toNav.view];
        [containerView addSubview:snapShotView];
 
        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            snapShotView.frame = toVC.toImageView.frame;
            snapShotView.transform = CGAffineTransformMakeScale(0.9, 0.9);
            toVC.view.alpha = 1;
        } completion:^(BOOL finished) {
            [snapShotView removeFromSuperview];
            toVC.toImageView.image = toVC.girlImage;
            [transitionContext completeTransition:YES];
        }];
        
    } else if (self.modeType == dismiss) {
        
        UINavigationController *fromNav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        GJ_TransitionViewController *fromVC = (GJ_TransitionViewController *)[[fromNav viewControllers]firstObject];
        UINavigationController *toNav = (UINavigationController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        GJ_AnimationViewController *toVC = (GJ_AnimationViewController *)[[toNav viewControllers] lastObject];

        UIView *containerView = [transitionContext containerView];
        UIImageView *baseImage = fromVC.toImageView;
        UIView *snapShotView = [baseImage snapshotViewAfterScreenUpdates:NO];
        snapShotView.frame = [containerView convertRect:baseImage.frame fromView:baseImage.superview];
        baseImage.hidden = YES;
        toVC.view.alpha = 0;
    
        [containerView addSubview:snapShotView];
        
        [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
             snapShotView.frame = toVC.girlImageView.frame;
             snapShotView.transform = CGAffineTransformMakeScale(1, 1);
             toVC.view.alpha = 1;
             fromVC.view.alpha = 0;
        } completion:^(BOOL finished) {
            [snapShotView removeFromSuperview];
            [fromVC.view removeFromSuperview];
            toVC.girlImageView.hidden = NO;
            [transitionContext completeTransition:YES];
        }];
   
    }
    

    
}

#pragma mark - Pop Animation



@end
