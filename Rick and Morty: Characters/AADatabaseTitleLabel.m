//
//  AATitleLabel.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADatabaseTitleLabel.h"


@implementation AADatabaseTitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = UIColor.redColor;
    }
    return self;
}

@end
