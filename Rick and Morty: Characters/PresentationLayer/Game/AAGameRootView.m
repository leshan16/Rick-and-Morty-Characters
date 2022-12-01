//
//  AAGameRootView.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameRootView.h"
#import "AAGamePicture.h"
#import "AAGameRootViewOutputProtocol.h"


@implementation AAGameRootView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.contents = (id)[UIImage imageNamed:@"GameLayer"].CGImage;
        
        _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, CGRectGetWidth(frame) / 3, CGRectGetWidth(frame) / 12)];
		_scoreLabel.backgroundColor = UIColor.whiteColor;
		_scoreLabel.layer.borderColor = UIColor.blackColor.CGColor;
		_scoreLabel.layer.borderWidth = CGRectGetWidth(frame) / 72;
		_scoreLabel.layer.masksToBounds = YES;
		_scoreLabel.layer.cornerRadius = CGRectGetWidth(frame) / 24;
		_scoreLabel.textColor = UIColor.redColor;
		_scoreLabel.textAlignment = NSTextAlignmentCenter;
		_scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
        [self addSubview:_scoreLabel];
        
		_bestScoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame) -
																	CGRectGetWidth(frame) / 3, 30,
																	CGRectGetWidth(frame) / 3,
																	CGRectGetWidth(frame) / 12)];
		_bestScoreLabel.backgroundColor = UIColor.whiteColor;
		_bestScoreLabel.layer.borderColor = UIColor.blackColor.CGColor;
		_bestScoreLabel.layer.borderWidth = CGRectGetWidth(frame) / 72;
		_bestScoreLabel.layer.masksToBounds = YES;
		_bestScoreLabel.layer.cornerRadius  = CGRectGetWidth(frame) / 24;
		_bestScoreLabel.textColor = UIColor.redColor;
		_bestScoreLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_bestScoreLabel];

        _questionLabel = [[UILabel alloc] initWithFrame:[self resultFrameQuestionLabel]];
		_questionLabel.backgroundColor = UIColor.blackColor;
		_questionLabel.layer.borderColor = UIColor.orangeColor.CGColor;
		_questionLabel.layer.borderWidth = CGRectGetWidth(frame) / 96;
		_questionLabel.layer.masksToBounds = YES;
		_questionLabel.layer.cornerRadius  = CGRectGetWidth(frame) / 16;
		_questionLabel.textColor = UIColor.orangeColor;
		_questionLabel.textAlignment = NSTextAlignmentCenter;
        _questionLabel.text = @"Question string";
        [self addSubview:_questionLabel];
        
        AAGamePicture *leftUpPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameLeftUpPicture]];
		leftUpPicture.tag = 0;
		UITapGestureRecognizer *tapOnLeftUpPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureSelected:)];
		[leftUpPicture addGestureRecognizer:tapOnLeftUpPicture];
        [self addSubview:leftUpPicture];
        
        AAGamePicture *rightUpPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameRightUpPicture]];
		rightUpPicture.tag = 1;
		UITapGestureRecognizer *tapOnRightUpPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureSelected:)];
		[rightUpPicture addGestureRecognizer:tapOnRightUpPicture];
        [self addSubview:rightUpPicture];
        
        AAGamePicture *leftDownPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameLeftDownPicture]];
		leftDownPicture.tag = 2;
		UITapGestureRecognizer *tapOnLeftDownPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureSelected:)];
		[leftDownPicture addGestureRecognizer:tapOnLeftDownPicture];
        [self addSubview:leftDownPicture];
        
        AAGamePicture *rightDownPicture = [[AAGamePicture alloc] initWithFrame:[self resultFrameRightDownPicture]];
		rightDownPicture.tag = 3;
		UITapGestureRecognizer *tapOnRightDownPicture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pictureSelected:)];
		[rightDownPicture addGestureRecognizer:tapOnRightDownPicture];
        [self addSubview:rightDownPicture];
        
        _arrayPictures = @[leftUpPicture, rightUpPicture, leftDownPicture, rightDownPicture];
        
		_activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(CGRectGetWidth(frame) / 2 - CGRectGetWidth(frame) / 8,
																					   CGRectGetHeight(frame) / 2 - CGRectGetWidth(frame) / 8,
																					   CGRectGetWidth(frame) / 4,
																					   CGRectGetWidth(frame) / 4)];
		_activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleLarge;
		_activityIndicator.color = UIColor.redColor;
        [self addSubview:_activityIndicator];
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


#pragma mark - UIGestureRecognizer

- (void)pictureSelected:(UIGestureRecognizer *)gestureRecognizer
{
    [self.output pictureSelected:gestureRecognizer.view.tag];
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
    return CGRectMake(0, CGRectGetHeight(self.frame) - CGRectGetWidth(self.frame) / 8 - self.safeAreaInsets.bottom - 10,
                      CGRectGetWidth(self.frame), CGRectGetWidth(self.frame) / 8);
}

@end
