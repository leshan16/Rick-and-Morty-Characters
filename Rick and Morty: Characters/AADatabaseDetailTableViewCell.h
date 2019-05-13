//
//  AADatabaseDetailTableViewCell.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN


/**
 Кастомная ячейка таблицы, содержащяя в себе наименование и значение характеристики персонажа
 */
@interface AADatabaseDetailTableViewCell : UITableViewCell

@property(nonatomic, strong) UILabel *leftLabel; /**< Наименование характеристики персонажа */
@property(nonatomic, strong) UILabel *rightLabel; /**< Значение характеристики персонажа */

@end


NS_ASSUME_NONNULL_END
