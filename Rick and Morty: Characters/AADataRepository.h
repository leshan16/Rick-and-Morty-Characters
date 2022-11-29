//
//  AADataRepository.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 04.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AADataRepositoryProtocol.h"


/**
 Класс принимает запрос от контроллера на получение данных. Определяет есть ли данные в кор дате, если есть, то берет из 
 нее, если их нет, то обращается к нетворк сервису за получением данных из сети. Обрабатывает данные из сети и отправляет 
 их контроллеру.
 */
@interface AADataRepository : NSObject <AADataRepositoryInputProtocol>

@property (nonatomic, nullable, weak) id<AADataRepositoryOutputProtocol> output; /**< Делегат внешних событий */

@end
