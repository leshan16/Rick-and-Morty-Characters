//
//  AAMainCollectionViewCell.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAMainCollectionViewCell.h"


@implementation AAMainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius  = frame.size.height / 10;
        _coverImageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
        _coverImageView.backgroundColor = UIColor.whiteColor;
        _coverImageView.contentMode = UIViewContentModeScaleToFill;
        [self.contentView addSubview:_coverImageView];
    }
    return self;
}


@end
