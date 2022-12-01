//
//  AAGameRootViewInputProtocol.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

@import Foundation;


/**
 Протокол уменьшения и увеличения размера окон
 */
@protocol AAGameRootViewInputProtocol <NSObject>

/**
 Метод устанавливает начальные положения окон
 */
- (void)installStartFrame;

/**
 Метод разворачивает окна пропорционально ширине дисплея
 */
- (void)installFinishFrame;

@end
