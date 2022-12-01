//
//  AAGameRootViewOutputProtocol.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 03.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

@class AAGamePicture;


/**
 Протокол передачи нажатия пользователя на картинку контроллеру
 */
@protocol AAGameRootViewOutputProtocol <NSObject>

/**
 Метод передает нажатие пользователя на картинку контроллеру

 @param selectedIndex Индекс картинки, на которую нажали
 */
- (void)pictureSelected:(NSInteger)selectedIndex;

@end
