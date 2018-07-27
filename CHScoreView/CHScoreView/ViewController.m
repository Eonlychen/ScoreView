//
//  ViewController.m
//  CHScoreView
//
//  Created by guxiangyun on 2018/7/26.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import "ViewController.h"
#import "CHScoreView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    __block UILabel *label = [UILabel new];
    label.frame = CGRectMake(100, 100,100, 30);
    label.adjustsFontSizeToFitWidth = true;
    [self.view addSubview:label];
    
    
    CHScoreView *scoreView = [[CHScoreView alloc] initWithFrame:CGRectMake(100, 200, 100, 15)];
    [scoreView setIsEnableScore:true];
    [scoreView setScore:3.f];
    [scoreView setScoreChangeBlock:^(float score) {
        [label setText:[NSString stringWithFormat:@"当前分数为：%.1f",score]];
    }];
    [self.view addSubview:scoreView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
