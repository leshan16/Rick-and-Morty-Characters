//
//  AADetailTableViewModel.h
//  Rick and Morty: Characters
//
//  Created by Апестин Алексей Дмитриевич on 30.11.2022.
//  Copyright © 2022 Алексей Апестин. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 Модель ячейки таблицы, содержащая в себе наименование и значение характеристики персонажа
 */
@interface AADetailTableViewModel : NSObject

@property(nonatomic, nullable, strong) NSString *name; /**< Наименование характеристики персонажа */
@property(nonatomic, nullable, strong) NSString *value; /**< Значение характеристики персонажа */

/**
 Создает экземпляр класса

 @param name Наименование характеристики персонажа
 @param value Значение характеристики персонажа

 @return Экземпляр класса
 */
- (instancetype)initWithName:(NSString *)name
					   value:(NSString *)value;

@end


NS_ASSUME_NONNULL_END
