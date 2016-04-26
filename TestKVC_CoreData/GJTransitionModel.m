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
    
    [containerView addSubview:snapShotView];
    [containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:self.animationDuration animations:^{
        toVC.view.alpha = 1;
        snapShotView.frame = [containerView convertRect:toVC.toImageView.frame fromView:toVC.view];
        snapShotView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        snapShotView.hidden  = YES;
        [transitionContext completeTransition:YES];
    }];
    
    
    
//    UIView *substituteView = [UIView new];
//    substituteView.frame = [containerView convertRect:toVC.toImageView.frame fromView:toVC.view];
//    POPSpringAnimation *anSpring = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
//    anSpring.toValue = @(substituteView.center.y);
//    anSpring.beginTime = CACurrentMediaTime();
//    anSpring.springBounciness = 5.0f;
//    [snapShotView pop_addAnimation:anSpring forKey:@"position"];
    
    
    
//    [UIView animateWithDuration:self.animationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:nil animations:^{
//        toVC.view.alpha = 1;
//        snapShotView.frame = [containerView convertRect:toVC.toImageView.frame fromView:toVC.view];
//        snapShotView.transform = CGAffineTransformMakeScale(0.5, 0.5);
//    } completion:^(BOOL finished) {
//        snapShotView.hidden  = YES;
//        [transitionContext completeTransition:YES];
//    }];
    
    
    
    
    
    
}

#pragma mark - Pop Animation



@end
