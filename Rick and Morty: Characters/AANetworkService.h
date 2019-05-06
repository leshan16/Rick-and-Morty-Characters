//
//  AANetworkService.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AANetworkServiceProtocol.h"


/**
 Класс, отправляющий запросы в сеть и получающий ответы из сети
 */
@interface AANetworkService : NSObject <AANetworkServiceIntputProtocol>

@property (nonatomic, weak) id<AANetworkServiceOutputProtocol> output; /**< Делегат внешних событий */

@end
