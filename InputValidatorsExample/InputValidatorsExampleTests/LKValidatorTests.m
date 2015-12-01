//
//  LKValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 28/11/2015.
//  Copyright © 2015 Ramotion. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKValidator.h"

@interface LKValidatorTests : XCTestCase

@end

@implementation LKValidatorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItCanBeInstantiatedWithClassMethod {
    LKValidator *validator = [LKValidator validator];
    XCTAssertNotNil(validator);
}

- (void)testThatItReturnsNoForDefautlImplementationValidateMethod {
    NSError *error = nil;
    LKValidator *validator = [LKValidator validator];
    XCTAssertFalse([validator validate:@"" error:&error]);
}

- (void)testThatItDoesNotCrashIfErrorNotPassedForValidateMethod {
    LKValidator *validator = [LKValidator validator];
    XCTAssertNoThrow([validator validate:@"" error:nil]);
}

@end
