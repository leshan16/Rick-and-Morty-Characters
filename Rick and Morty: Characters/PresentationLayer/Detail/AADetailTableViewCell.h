//
//  AADetailTableViewCell.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

@import UIKit;


/**
 Ячейка таблицы, содержащая в себе наименование и значение характеристики персонажа
 */
@interface AADetailTableViewCell : UITableViewCell

@property(nonatomic, nullable, strong) UILabel *nameLabel; /**< Наименование характеристики персонажа */
@property(nonatomic, nullable, strong) UILabel *valueLabel; /**< Значение характеристики персонажа */

@end
