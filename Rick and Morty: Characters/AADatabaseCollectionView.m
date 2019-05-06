//
//  AADatabaseCollectionView.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADatabaseCollectionView.h"
#import "AADatabaseCollectionViewCell.h"


@implementation AADatabaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self)
    {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.contents = (id)[UIImage imageNamed:@"RickLayer"].CGImage;
        [self registerClass:[AADatabaseCollectionViewCell class]
 forCellWithReuseIdentifier:NSStringFromClass([AADatabaseCollectionViewCell class])];
    }
    return self;
}

@end
