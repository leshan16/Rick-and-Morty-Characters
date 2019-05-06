//
//  AAGameQuestionLabel.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameQuestionLabel.h"


@implementation AAGameQuestionLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIColor.blackColor;
        self.layer.borderColor = UIColor.orangeColor.CGColor;
        self.layer.borderWidth = CGRectGetHeight(frame) / 12;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = CGRectGetHeight(frame) / 2;
        self.textColor = UIColor.orangeColor;
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
