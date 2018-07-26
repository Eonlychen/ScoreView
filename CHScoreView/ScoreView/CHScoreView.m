//
//  CHScoreView.m
//  CHScoreView
//
//  Created by guxiangyun on 2018/7/26.
//  Copyright © 2018年 chenran. All rights reserved.
//

#import "CHScoreView.h"

@interface CHScoreView()
{
    UIView *showView;//上层view
    UIView *hideView;//底部view
    UILabel *scoreLabel;
    
    NSMutableArray *showViewArray;
    NSMutableArray *hideViewArray;
}

@end

@implementation CHScoreView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        showViewArray = [[NSMutableArray alloc] init];
        hideViewArray = [[NSMutableArray alloc] init];
        
        self.backgroundColor = [UIColor whiteColor];
        self.isEnableScore = NO;
        double starWidth = 15.0;
        showView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, starWidth*5.0, self.frame.size.height)];
        hideView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, starWidth*5.0, self.frame.size.height)];
        
        for(int i = 0 ; i < 5 ; i++){
            UIImageView *starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*starWidth, 0.0, starWidth, starWidth)];
            starImageView.image = [UIImage imageNamed:@"scoreShow"];
            [starImageView setTag:(1000+i )];
            [starImageView setUserInteractionEnabled:YES];
            UITapGestureRecognizer *selectPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeNewScore:)];
            [starImageView addGestureRecognizer:selectPress];
            [showView addSubview:starImageView];
            [showViewArray addObject:starImageView];
            
            UIImageView *starImageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(i*starWidth, 0.0, starWidth, starWidth)];
            starImageView1.image =  [UIImage imageNamed:@"scoreHide"];
            [starImageView1 setTag:(2000+i )];
            [starImageView1 setUserInteractionEnabled:YES];
            UITapGestureRecognizer *unSelectPress = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(makeNewScore:)];
            [starImageView1 addGestureRecognizer:unSelectPress];
            [hideView addSubview:starImageView1];
            [hideViewArray addObject:starImageView1];
        }
        
        showView.clipsToBounds = YES;
        
        [self addSubview:hideView];
        [self addSubview:showView];
        showView.backgroundColor = [UIColor clearColor];
        scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(hideView.frame) + 5, 1.0, 35.0, 13)];
        scoreLabel.textColor = [UIColor grayColor];
        scoreLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:scoreLabel];
    }
    return self;
}


-(void)setScore:(float)score{
    double vscore = MAX(MIN(5.0, score), 0.0);
    _score = vscore;
    float flag = vscore / 5.0;
    
    CGRect rect = hideView.frame;
    rect.size.width = rect.size.width * flag;
    showView.frame = rect;
    
    scoreLabel.text = [NSString stringWithFormat:@"%0.1f分",_score];
}


-(void)setIsShowScore:(BOOL)isShowScore{
    
    if(isShowScore){
        scoreLabel.hidden = NO;
        scoreLabel.text = [NSString stringWithFormat:@"%f分",_score];
    }
    else{
        scoreLabel.hidden = YES;
    }
}

-(void)updateScoreHigtLightImage:(UIImage *)scoreHigtLightImage
            ScoreBackgroundImage:(UIImage *)scoreBackgroundImage
{
    for(UIImageView *imageView in showViewArray){
        imageView.image = scoreHigtLightImage;
    }
    
    for(UIImageView *imageView in hideViewArray){
        imageView.image = scoreBackgroundImage;
    }
}
/*
 打分操作
 设置isEnableScore=YES时，可以使用打分操作。否则不可用
 */

#pragma mark- 打分操作
- (void)makeNewScore:(UITapGestureRecognizer *)sender
{
    if(self.isEnableScore){
        if (sender.view.tag>1999) {
            [self setScore:(sender.view.tag-1999)];
        }else{
            [self setScore:(sender.view.tag-999)];
        }
    }
    
    if (self.ScoreChangeBlock) {
        self.ScoreChangeBlock(self.score);
    }
    
}
@end
