//
//  AADetailTableViewCell.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADetailTableViewCell.h"


static const CGFloat AAMarginOffset = 10.0;


@implementation AADetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.contentView.backgroundColor = UIColor.clearColor;
        
        _nameLabel = [UILabel new];
		_nameLabel.textColor = UIColor.grayColor;
		_nameLabel.textAlignment = NSTextAlignmentLeft;
		_nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [self.contentView addSubview:_nameLabel];
        
        _valueLabel = [UILabel new];
		_valueLabel.textColor = UIColor.orangeColor;
		_valueLabel.textAlignment = NSTextAlignmentRight;
		_valueLabel.translatesAutoresizingMaskIntoConstraints = NO;
		_valueLabel.numberOfLines = 0;
        [self.contentView addSubview:_valueLabel];
        
        [NSLayoutConstraint activateConstraints:@[[_nameLabel.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor
                                                                                        constant:AAMarginOffset],
                                                  [_nameLabel.widthAnchor constraintEqualToConstant:100.0],
                                                  [_nameLabel.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor],
                                                  
                                                  [_valueLabel.leftAnchor constraintEqualToAnchor:_nameLabel.rightAnchor],
                                                  [_valueLabel.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor
                                                                                          constant:-AAMarginOffset],
                                                  [_valueLabel.heightAnchor constraintEqualToAnchor:self.contentView.heightAnchor]
                                                  ]];
    }
    return self;
}

@end
