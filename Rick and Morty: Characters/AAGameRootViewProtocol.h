//
//  AAGameRootViewProtocol.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

/**
 Протокол уменьшения и увеличения размера окон
 */
@protocol AAGameRootViewProtocol <NSObject>

/**
 Метод устанавливает начальные положения окон
 */
- (void)installStartFrame;

/**
 Метод разворачивает окна пропорционально ширине дисплея
 */
- (void)installFinishFrame;

@end
