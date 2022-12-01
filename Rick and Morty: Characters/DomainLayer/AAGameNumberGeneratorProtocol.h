//
//  AAGameNumberGeneratorProtocol.h
//  Rick and Morty: Characters
//
//  Created by Апестин Алексей Дмитриевич on 30.11.2022.
//  Copyright © 2022 Алексей Апестин. All rights reserved.
//

@import Foundation;


NS_ASSUME_NONNULL_BEGIN


/**
 Протокол генератора случайных чисел в зависимости от текущего времени
 */
@protocol AAGameNumberGeneratorProtocol <NSObject>

/**
 Метод создает случайное число от 0 до 3

 @param currentDate Текущая дата
 @return Случайное число от 0 до 3
 */
- (NSInteger)getRandomNumber0to3FromDate:(nullable NSDate *)currentDate;


/**
 Метод создает 4 случайных числа от 0 до 493

 @param currentDate Текущая дата
 @return Массив из 4 случайных чисел от 0 до 493(общего числа персонажей)
 */
- (NSArray<NSNumber *> *)getRandomFourNumbers1to493FromDate:(nullable NSDate *)currentDate;

@end


NS_ASSUME_NONNULL_END
