//
//  AAGameRootView.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameRootView.h"
#import "AAGameScoreLabel.h"
#import "AAGamePicture.h"
#import "AAGameQuestionLabel.h"
#import "AAActivityIndicatorView.h"


@interface AAGameRootView() <AAGamePictureProtocol>

@end

@implementation AAGameRootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.contents = (id)[UIImage imageNamed:@"GameLayer"].CGImage;
        
        _scoreLabel = [[AAGameScoreLabel alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(frame) / 3,
                                                                             CGRectGetWidth(frame) / 12)];
        _scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
        [self addSubview:_scoreLabel];
        
        _bestScoreLabel = [[AAGameScoreLabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame) -
                                                                                 CGRectGetWidth(frame) / 3, 30,
                                                                                 CGRectGetWidth(frame) / 3,
                                                                                 CGRectGetWidth(frame) / 12)];
        [self addSubview:_bestScoreLabel];
        
        _questionLabel = [[AAGameQuestionLabel alloc] initWithFrame:[self resultFrameQuestionLabel]];
        _questionLabel.text = @"Question string";
        [self addSubview:_questionLabel];
        
        AAGamePicture *leftUpPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameLeftUpPicture]];
        leftUpPicture.output = self;
        [self addSubview:leftUpPicture];
        
        AAGamePicture *rightUpPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameRightUpPicture]];
        rightUpPicture.output = self;
        [self addSubview:rightUpPicture];
        
        AAGamePicture *leftDownPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameLeftDownPicture]];
        leftDownPicture.output = self;
        [self addSubview:leftDownPicture];
        
        AAGamePicture *rightDownPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameRightDownPicture]];
        rightDownPicture.output = self;
        [self addSubview:rightDownPicture];
        
        _arrayPictures = @[leftUpPicture, rightUpPicture, leftDownPicture, rightDownPicture];
        
        _activityIndicator = [[AAActivityIndicatorView alloc]
                                  initWithFrame:CGRectMake(CGRectGetWidth(frame) / 2 - CGRectGetWidth(frame) / 8,
                                                           CGRectGetHeight(frame) / 2 - CGRectGetWidth(frame) / 8,
                                                           CGRectGetWidth(frame) / 4, CGRectGetWidth(frame) / 4)];
        [self addSubview:_activityIndicator];
        [_activityIndicator startAnimating];
    }
    return self;
}


#pragma mark - AAGameRootViewProtocol

- (void)installStartFrame
{
    CGRect startFrame = CGRectMake(CGRectGetWidth(self.frame) / 2,
                                   (CGRectGetMinY(self.questionLabel.frame) - CGRectGetMaxY(self.scoreLabel.frame)) / 2 +
                                   CGRectGetMaxY(self.scoreLabel.frame), 0, 0);
    for (AAGamePicture *gamePicture in self.arrayPictures)
    {
        gamePicture.frame = startFrame;
    }
    self.questionLabel.frame = CGRectMake(CGRectGetWidth(self.frame) / 2, CGRectGetMinY(self.questionLabel.frame),
                                          0, CGRectGetHeight(self.questionLabel.frame));
}


- (void)installFinishFrame
{
    self.questionLabel.frame = [self resultFrameQuestionLabel];
    self.arrayPictures[0].frame = [self resultFrameLeftUpPicture];
    self.arrayPictures[1].frame = [self resultFrameRightUpPicture];
    self.arrayPictures[2].frame = [self resultFrameLeftDownPicture];
    self.arrayPictures[3].frame = [self resultFrameRightDownPicture];
    for (AAGamePicture *gamePicture in self.arrayPictures)
    {
        gamePicture.layer.borderColor = UIColor.blackColor.CGColor;
    }
}


#pragma mark - AAGamePictureProtocol

- (void)pictureSelected:(AAGamePicture *)picture
{
    [self.output pictureSelected:picture];
}


#pragma mark - Install final frame

- (CGRect)resultFrameLeftUpPicture
{
    return CGRectMake(0, (CGRectGetMinY(self.questionLabel.frame) - CGRectGetMaxY(self.scoreLabel.frame)) / 2 +
                      CGRectGetMaxY(self.scoreLabel.frame) - CGRectGetWidth(self.frame) / 2 - 1,
                      CGRectGetWidth(self.frame) / 2 - 1, CGRectGetWidth(self.frame) / 2);
}


- (CGRect)resultFrameRightUpPicture
{
    return CGRectMake(CGRectGetWidth(self.arrayPictures[0].frame) + 2, CGRectGetMinY(self.arrayPictures[0].frame),
                      CGRectGetWidth(self.frame) / 2 - 1, CGRectGetWidth(self.frame) / 2);
}


- (CGRect)resultFrameLeftDownPicture
{
    return CGRectMake(0, CGRectGetMaxY(self.arrayPictures[0].frame) + 2, CGRectGetWidth(self.frame) / 2 - 2,
                      CGRectGetWidth(self.frame) / 2);
}


- (CGRect)resultFrameRightDownPicture
{
    return CGRectMake(CGRectGetWidth(self.arrayPictures[0].frame) + 2, CGRectGetMaxY(self.arrayPictures[0].frame) + 2,
                      CGRectGetWidth(self.frame) / 2 - 1, CGRectGetWidth(self.frame) / 2);
}


- (CGRect)resultFrameQuestionLabel
{
    return CGRectMake(0, CGRectGetHeight(self.frame) - CGRectGetWidth(self.frame) / 8 - 80,
                      CGRectGetWidth(self.frame), CGRectGetWidth(self.frame) / 8);
}

@end
