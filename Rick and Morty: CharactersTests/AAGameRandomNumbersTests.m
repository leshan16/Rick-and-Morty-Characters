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
    NSDate *testDate = [[NSDate alloc] initWithTimeIntervalSince1970:7];
    NSInteger result = [AAGameRandomNumbers getRandomNumberFrom0to3:testDate];
    XCTAssertEqual(result, 1);
}


- (void)testRandomFourNumbersFrom1to493
{
    NSDate *testDate = [[NSDate alloc] initWithTimeIntervalSince1970:492];
    NSArray<NSNumber *> *result = [AAGameRandomNumbers getRandomFourNumbersFrom1to493:testDate];
    XCTAssertEqual(result.count, 4);
    XCTAssertEqual([result[0] integerValue], 469);
    XCTAssertEqual([result[1] integerValue], 482);
    XCTAssertEqual([result[2] integerValue], 443);
    XCTAssertEqual([result[3] integerValue], 430);
}
@end
