//
//  AADataService.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AADataServiceProtocol.h"


/**
 Класс принимает запрос от контроллера на получение данных. Определяет есть ли данные в кор дате, если есть, то берет из 
 нее, если их нет, то обращается к нетворк сервису за получением данных из сети. Обрабатывает данные из сети и отправляет 
 их контроллеру.
 */
@interface AADataService : NSObject <AADataServiceInputProtocol>

@property (nonatomic, nullable, weak) id<AADataServiceOutputProtocol> output; /**< Делегат внешних событий */

@end
