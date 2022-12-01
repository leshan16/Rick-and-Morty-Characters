//
//  AAGameNumberGeneratorTests.m
//  Rick and Morty: CharactersTests
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

@import XCTest;
#import "AAGameNumberGenerator.h"


@interface AAGameNumberGeneratorTests : XCTestCase

@property (nonatomic, nullable, strong) AAGameNumberGenerator *sut;

@end

@implementation AAGameNumberGeneratorTests

- (void)setUp
{
    [super setUp];
	self.sut = [AAGameNumberGenerator new];
}

- (void)tearDown
{
	self.sut = nil;
    [super tearDown];
}

- (void)testRandomNumberFrom0to3
{
	// Arrange
    NSDate *testDate = [[NSDate alloc] initWithTimeIntervalSince1970:7];

	// Act
    NSInteger result = [self.sut getRandomNumber0to3FromDate:testDate];

	// Assert
    XCTAssertEqual(result, 3);
}


- (void)testRandomFourNumbersFrom1to493
{
	// Arrange
    NSDate *testDate = [[NSDate alloc] initWithTimeIntervalSince1970:492];

	// Act
    NSArray<NSNumber *> *result = [self.sut getRandomFourNumbers1to493FromDate:testDate];

	// Assert
    XCTAssertEqual(result.count, 4);
    XCTAssertEqual([result[0] integerValue], 469);
    XCTAssertEqual([result[1] integerValue], 482);
    XCTAssertEqual([result[2] integerValue], 443);
    XCTAssertEqual([result[3] integerValue], 430);
}
@end
