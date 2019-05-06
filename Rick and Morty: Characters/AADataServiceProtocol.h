//
//  AADataServiceProtocol.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

@class AACharacterModel;


/**
 Протокол обновления UI новыми персонажами, а также появление предупреждений пользователю
 */
@protocol AADataServiceOutputProtocol <NSObject>

/**
 Метод показывает пользователю предупреждение с заданным текстом

 @param textAlert Текст предупреждения
 */
- (void)showAlert:(NSString *)textAlert;

/**
 Метод обновленяет UI новыми персонажами

 @param charactersInfo Массив новых персонажей
 */
- (void)addNewPage:(NSMutableArray<AACharacterModel *> *)charactersInfo;

@end


/**
 Протокол получения данных из сети или кор даты
 */
@protocol AADataServiceInputProtocol <NSObject>

/**
 Метод получает данные из нетворк сервиса или кор даты
 */
- (void)getCharactersInfo;

@end
