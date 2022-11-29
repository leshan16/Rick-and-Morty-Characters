//
//  AANetworkServiceProtocol.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//


@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 Протокол отправки запроса в сеть и получение данных из сети
 */
@protocol AANetworkServiceProtocol <NSObject>

/**
 Метод отправляет запрос в сеть для получения странницы персонажей

 @param page Страница для загрузки
 @param completionHandler Замыкание с результатом выполнения запроса
 */
- (void)downloadCharactersInfoForPage:(NSInteger)page completionHandler:(void (^)(NSData * _Nullable))completionHandler;

/**
  Метод отправляет запрос в сеть для получения персонажей по их идентификаторам

 @param arraySearchID Идентификаторы персонажей
 @param completionHandler Замыкание с результатом выполнения запроса
 */
- (void)downloadCharactersInfoForIds:(NSArray<NSNumber *> *)arraySearchID completionHandler:(void (^)(NSData * _Nullable))completionHandler;

/**
 Метод отправляет запрос в сеть для получения изображения персонажа

 @param urlStringImage Строка URL
 @param completionHandler Замыкание с результатом выполнения запроса
 */
- (void)downloadCharacterImage:(nullable NSString *)urlStringImage completionHandler:(void (^)(NSData * _Nullable))completionHandler;

/**
 Метод проверяет текущее состояние интернет соединения

 @return Cостояние интернет соединения
 */
- (BOOL)isInternetConnectionAvailable;

@end


NS_ASSUME_NONNULL_END
