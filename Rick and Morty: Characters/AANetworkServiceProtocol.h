//
//  AANetworkServiceProtocol.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

/**
 Протокол обработки данных, полученных из сети или из кор даты
 */
@protocol AANetworkServiceOutputProtocol <NSObject>

/**
 Метод обрабатывает данные, полученные из сети

 @param charactersInfo Данные персонажа
 */
- (void)downloadNewPage:(nullable NSData *)charactersInfo;

@end


/**
 Протокол отправки запроса в сеть и получение данных из сети
 */
@protocol AANetworkServiceIntputProtocol <NSObject>

/**
 Метод отправляет запрос в сеть для конкретной странницы данных ресурса

 @param page Страница для загрузки
 */
- (void)downloadCharactersInfo:(NSInteger)page;

/**
  Метод отправляет запрос в сеть для конкретных персонажей по их идентификаторам

 @param arraySearchID Идентификаторы персонажей
 */
- (void)downloadCharactersInfoForGame:(nullable NSArray<NSNumber *> *)arraySearchID;

/**
 Метод отправляет запрос в сеть по конкретному URL и возвращает полученные данные

 @param urlStringImage Строка URL
 @return Данные из сети
 */
- (nullable NSData *)downloadCharacterImage:(nullable NSString *)urlStringImage;


/**
 Метод проверяет текущее состояние интернет соединения

 @return Cостояние интернет соединения
 */
- (BOOL)checkInternetConnection;

@end

