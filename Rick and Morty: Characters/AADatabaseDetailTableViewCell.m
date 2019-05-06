//
//  AADatabaseDetailTableViewCell.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADatabaseDetailTableViewCell.h"

static const CGFloat AAMarginOffset = 10.0;


@implementation AADatabaseDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor = UIColor.blackColor;
        
        _leftLabel = [UILabel new];
        _leftLabel.textColor = UIColor.grayColor;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
        _leftLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_leftLabel];
        
        _rightLabel = [UILabel new];
        _rightLabel.textColor = UIColor.orangeColor;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _rightLabel.numberOfLines = 0;
        [self.contentView addSubview:_rightLabel];
        
        [NSLayoutConstraint activateConstraints:@[[_leftLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor
                                                                                        constant:AAMarginOffset],
                                                  [_leftLabel.widthAnchor constraintEqualToConstant:100.0],
                                                  [_leftLabel.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor],
                                                  
                                                  [_rightLabel.leftAnchor constraintEqualToAnchor:_leftLabel.rightAnchor],
                                                  [_rightLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor
                                                                                          constant:-AAMarginOffset],
                                                  [_rightLabel.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor]
                                                  ]];
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
