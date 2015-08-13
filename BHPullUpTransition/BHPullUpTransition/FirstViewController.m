//
//  ViewController.m
//  BHPullUpTransition
//
//  Created by libohao on 15/8/13.
//  Copyright (c) 2015年 libohao. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "BHTransitionFromFirstToSecond.h"

@interface FirstViewController ()<UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView* backGroundImageView;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePushTransition;
@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@end

@implementation FirstViewController

#pragma Property

- (UIImageView* )backGroundImageView {
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _backGroundImageView.image = [UIImage imageNamed:@"2"];
    }
    return _backGroundImageView;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backGroundImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
    self.navigationController.delegate = self;
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanRecognizer:)];
    [self.view addGestureRecognizer:self.panRecognizer];
}

- (void)viewDidDisappear:(BOOL)animated {
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}



#pragma mark UINavigationControllerDelegate methods

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    if (fromVC == self && [toVC isKindOfClass:[SecondViewController class]]) {
        return [[BHTransitionFromFirstToSecond alloc] init];
    }
    else {
        return nil;
    }
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[BHTransitionFromFirstToSecond class]]) {
        return self.interactivePushTransition;
    }
    else {
        return nil;
    }
}

- (void)handlePanRecognizer:(UIPanGestureRecognizer*)recognizer {
    static CGFloat startLocationY = 0;
    CGPoint location = [recognizer locationInView:self.view];
    CGFloat progress = (location.y - startLocationY) / [UIScreen mainScreen].bounds.size.width;
    progress = -progress;
    //NSLog(@"progress:   %.2f", progress);
    
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        startLocationY = location.y;
        self.interactivePushTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        SecondViewController* vc = [[SecondViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGFloat offset = location.y - startLocationY;
        NSLog(@"progress:   %.2f", offset);
        [self.interactivePushTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.3) {
            self.interactivePushTransition.completionSpeed = 0.4;
            [self.interactivePushTransition finishInteractiveTransition];
        }
        else {
            self.interactivePushTransition.completionSpeed = 0.3;
            [self.interactivePushTransition cancelInteractiveTransition];
        }
        self.interactivePushTransition = nil;
    }
    
}


@end
