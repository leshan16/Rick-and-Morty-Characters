//
//  AANetworkService.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 28.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AANetworkServiceProtocol.h"


/**
 Класс, отправляющий запросы в сеть и получающий ответы из сети
 */
@interface AANetworkService : NSObject <AANetworkServiceProtocol>

@end
