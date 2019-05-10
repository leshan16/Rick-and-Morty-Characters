//
//  AAGameRandomNumbers.h
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Класс генерирует случайные числа в зависимости от текущего времени
 */
@interface AAGameRandomNumbers : NSObject

/**
 Метод создает случайное число от 0 до 3

 @return Случайное число от 0 до 3
 */
+ (NSInteger)getRandomNumberFrom0to3;


/**
 Метод создает 4 случайных числа от 0 до extremeNumber

 @param extremeNumber Правая граница интервала случайных чисел
 @return Массив из 4 случайных чисел от 0 до extremeNumber
 */
+ (NSArray<NSNumber *> *)getRandomFourNumbersFrom0toX:(NSInteger)extremeNumber;

@end
