//
//  SecondViewController.m
//  BHPullUpTransition
//
//  Created by libohao on 15/8/13.
//  Copyright (c) 2015年 libohao. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIImageView* backGroundImageView;

@end

@implementation SecondViewController

- (UIImageView* )backGroundImageView {
    if (!_backGroundImageView) {
        _backGroundImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
        _backGroundImageView.image = [UIImage imageNamed:@"1"];
        _backGroundImageView.clipsToBounds = YES;
    }
    return _backGroundImageView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.backGroundImageView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
