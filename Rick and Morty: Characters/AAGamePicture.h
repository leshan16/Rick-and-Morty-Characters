//
//  AAGamePicture.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 29.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAGamePictureProtocol.h"


/**
 Контейнер для картинки, который передает нажатие пользователя делегату
 */
@interface AAGamePicture : UIImageView

@property (nonatomic, nullable, weak) id<AAGamePictureProtocol> output; /**< Делегат внешних событий */
@property(nonatomic, nullable, copy) NSString *characterName; /**< Имя персонажа*/

@end
