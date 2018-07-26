//
//  CHScoreView.h
//  CHScoreView
//
//  Created by guxiangyun on 2018/7/26.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHScoreView : UIView
@property (nonatomic) BOOL isShowScore;//是否显示分数
@property (nonatomic, assign) float score;//设置分数
@property (nonatomic, assign) BOOL isEnableScore;//是否可用于打分，默认一共5分；
@property (nonatomic, copy) void (^ScoreChangeBlock)(float score);//分数改变的回调

-(void)updateScoreHigtLightImage:(UIImage *)scoreHigtLightImage
           ScoreBackgroundImage:(UIImage *)scoreBackgroundImage;
@end
