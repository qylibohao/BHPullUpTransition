//
//  CMTransitionFromFirstToSecond
//  Chimian
//
//  Created by libohao on 15/5/9.
//
//

#import "BHTransitionFromFirstToSecond.h"

#import "FirstViewController.h"
#import "SecondViewController.h"


@implementation BHTransitionFromFirstToSecond

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    FirstViewController *fromViewController = (FirstViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    SecondViewController *toViewController = (SecondViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];

    UIView *imageSnapshot = [[UIApplication sharedApplication].keyWindow snapshotViewAfterScreenUpdates:NO];
    imageSnapshot.frame = fromViewController.view.frame;
    toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.alpha = 0;
    [containerView addSubview:toViewController.view];
    [containerView addSubview:imageSnapshot];

    [UIView animateWithDuration:duration animations:^{
        toViewController.view.alpha = 1.0;
        imageSnapshot.alpha = 0.0;
        imageSnapshot.transform=CGAffineTransformTranslate(imageSnapshot.transform, 0, -100);
    } completion:^(BOOL finished) {
        NSLog(@"remove screenshot-----------");
        [imageSnapshot removeFromSuperview];
        fromViewController.view.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

@end
