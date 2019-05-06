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
- (void)downloadNewPage:(NSData *)charactersInfo;

@optional

/**
 Метод извлекает данные из кор даты, и дополняет их данными из сети

 @param isInternetConnection Текущее состояние интернет соединения
 */
- (void)getCharactersInfoFromCoreData:(BOOL)isInternetConnection;

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
- (void)downloadCharactersInfoForGame:(NSArray<NSNumber *> *)arraySearchID;

/**
 Метод отправляет запрос в сеть по конкретному URL и возвращает полученные данные

 @param urlStringImage Строка URL
 @return Данные из сети
 */
- (NSData *)downloadCharacterImage:(NSString *)urlStringImage;

/**
 Метод проверяет текущее состояние интернет соединения
 */
- (void)checkInternetConnection;

@end

