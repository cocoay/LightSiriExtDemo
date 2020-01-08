//
//  ViewController.m
//  YZLight
//
//  Created by Jinya on 2020/1/8.
//  Copyright © 2020 Cocoa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *nameLb;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView {
    self.nameLb = ({
        UILabel *aView = [[UILabel alloc] init];
        [self.view addSubview:aView];
        aView.text = @"谢谢你";
        [aView sizeToFit];
        aView.center = self.view.center;
        aView;
    });
}

@end
