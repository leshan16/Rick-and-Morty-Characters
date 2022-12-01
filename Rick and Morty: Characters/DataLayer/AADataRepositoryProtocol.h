//
//  AADataRepositoryProtocol.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

@import Foundation;
@class AACharacterModel;


NS_ASSUME_NONNULL_BEGIN


/**
 Протокол обновления UI новыми персонажами, а также появление ошибок пользователю
 */
@protocol AADataRepositoryOutputProtocol <NSObject>

/**
 Получена ошибка при загрузке данных

 @param description Текст ошибки
 */
- (void)didRecieveErrorWithDescription:(nullable NSString *)description;

/**
 Загружены данные персонажей

 @param charactersInfo Массив новых персонажей
 */
- (void)didLoadCharactersInfo:(nullable NSArray<AACharacterModel *> *)charactersInfo;

@end


/**
 Протокол получения данных из сети или кор даты
 */
@protocol AADataRepositoryInputProtocol <NSObject>

/**
 Метод получает данные страницы персонажей

 @param page Номер страницы
 */
- (void)getCharactersInfoForPage:(NSInteger)page;

/**
 Метод получает данные персонажей

 @param arraySearchID Идентификаторы персонажей
 */
- (void)getCharactersInfoForIds:(NSArray<NSNumber *> *)arraySearchID;

@end


NS_ASSUME_NONNULL_END
