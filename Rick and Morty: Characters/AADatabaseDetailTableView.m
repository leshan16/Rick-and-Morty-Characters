//
//  AADatabaseDetailTableView.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADatabaseDetailTableView.h"
#import "AADatabaseDetailTableViewCell.h"


@implementation AADatabaseDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        self.rowHeight = CGRectGetHeight(frame) / 4;
        self.backgroundColor = UIColor.blackColor;
        [self registerClass:[AADatabaseDetailTableViewCell class]
     forCellReuseIdentifier:NSStringFromClass([AADatabaseDetailTableViewCell class])];
    }
    return self;
}

@end
