//
//  AAGameRandomNumbers.m
//  Rick and Morty: Characters
//
//  Created by Алексей Апестин on 10.05.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import "AAGameRandomNumbers.h"


@implementation AAGameRandomNumbers

+ (NSInteger)getRandomNumberFrom0to3:(NSDate *)currentDate
{
    return [[self getDateComponents:currentDate] second] % 3;
}


+ (NSArray<NSNumber *> *)getRandomFourNumbersFrom1to493:(NSDate *)currentDate
{
    NSDateComponents *dateComponents = [self getDateComponents:currentDate];
    
    NSInteger hour = [dateComponents hour] + 1;
    NSInteger minute = [dateComponents minute] + 1;
    NSInteger second = [dateComponents second] + 1;
    NSInteger searchID = (second * minute * hour) % 493 + 1;
    
    NSMutableArray *arraySearchIDCharacters = [NSMutableArray new];
    [arraySearchIDCharacters addObject:@(searchID)];
    
    for (int i = 1; i < 4; i++)
    {
        NSInteger nextID = searchID + second * i;
        if (nextID > 493)
        {
            nextID = searchID - second * i;
        }
        [arraySearchIDCharacters addObject:@(nextID)];
    }
    return [arraySearchIDCharacters copy];
}


+ (NSDateComponents *)getDateComponents:(nullable NSDate *)currentDate
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian components:(NSCalendarUnitHour  | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:currentDate];
}

@end
