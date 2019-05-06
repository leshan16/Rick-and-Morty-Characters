//
//  AAActivityIndicatorView.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAActivityIndicatorView.h"


@implementation AAActivityIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        self.color = UIColor.redColor;
    }
    return self;
}

@end
