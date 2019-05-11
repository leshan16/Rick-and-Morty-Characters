//
//  Rick_and_Morty__CharactersTests.m
//  Rick and Morty: CharactersTests
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AAGameRandomNumbers.h"

@interface AAGameRandomNumbersTests : XCTestCase

@end

@implementation AAGameRandomNumbersTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testRandomNumberFrom0to3
{
    NSInteger result = [AAGameRandomNumbers getRandomNumberFrom0to3];
    XCTAssertGreaterThanOrEqual(result, 0);
    XCTAssertLessThanOrEqual(result, 3);
}


- (void)testRandomFourNumbersFrom1to493
{
    NSArray<NSNumber *> *result = [AAGameRandomNumbers getRandomFourNumbersFrom1to493];
    XCTAssertEqual(result.count, 4);
    for (NSNumber *searchID in result)
    {
        XCTAssertGreaterThanOrEqual([searchID integerValue], 1);
        XCTAssertLessThanOrEqual([searchID integerValue], 493);
    }
    NSSet *resultSet = [NSSet setWithArray:result];
    XCTAssertEqual(resultSet.count, 4);
}
@end
