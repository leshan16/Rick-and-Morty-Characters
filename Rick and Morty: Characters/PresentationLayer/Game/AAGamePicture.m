//
//  AAGamePicture.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGamePicture.h"


@implementation AAGamePicture

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.borderColor = UIColor.blackColor.CGColor;
        self.layer.borderWidth = CGRectGetHeight(frame) / 30;
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = CGRectGetHeight(frame) / 4;
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
