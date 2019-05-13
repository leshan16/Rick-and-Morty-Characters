//
//  AADatabaseCollectionViewCell.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 Кастомная ячейка коллекции, содержащяя в себе картинку персонажа
 */
@interface AADatabaseCollectionViewCell : UICollectionViewCell

@property (nonatomic, nullable, strong) UIImageView *coverImageView; /**< Контейнер для картинки персонажа */

@end
