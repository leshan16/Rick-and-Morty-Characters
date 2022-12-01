//
//  AACoreDataServiceProtocol.h
//  Rick and Morty: Characters
//
//  Created by Апестин Алексей Дмитриевич on 29.11.2022.
//  Copyright © 2022 Алексей Апестин. All rights reserved.
//

@import Foundation;
@class AACharacterModel;


NS_ASSUME_NONNULL_BEGIN


/**
 Интерфейс взаимодействия с локальной базой данных
 */
@protocol AACoreDataServiceProtocol <NSObject>

/**
 Метод сохраняет данные персонажей в базу данных

 @param charactersInfo Информация об персонажах
 */
- (void)saveCharactersInfo:(NSArray<AACharacterModel *> *)charactersInfo;

/**
 Метод получает данные персонажей из базы данных

 @param page Номер страницы с персонажами
 */
- (NSArray<AACharacterModel *> *)getCharactersInfoForPage:(NSInteger)page;

@end


NS_ASSUME_NONNULL_END
