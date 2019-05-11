//
//  Rick_and_Morty__CharactersUITests.m
//  Rick and Morty: CharactersUITests
//
//  Created by Алексей Апестин on 24.04.19.
//  Copyright © 2019 Алексей Апестин. All rights reserved.
//

#import <XCTest/XCTest.h>


@interface Rick_and_Morty__CharactersUITests : XCTestCase

@end


@implementation Rick_and_Morty__CharactersUITests

- (void)setUp
{
    [super setUp];
    
    self.continueAfterFailure = NO;
    [[[XCUIApplication alloc] init] launch];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testExample
{

}

@end
