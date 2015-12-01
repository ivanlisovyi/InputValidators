//
//  LKAlphaValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 01/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKAlphaValidator.h"

@interface LKAlphaValidatorTests : XCTestCase

@property (nonatomic, strong) LKAlphaValidator *sut;

@end

@implementation LKAlphaValidatorTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKAlphaValidator validator];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItHasADefaultError {
    XCTAssertTrue(self.sut.error.code == LKValidatorAlphaErrorCode);
}

- (void)testThatItHasARegex {
    XCTAssertNotNil(self.sut.regex);
}

- (void)testThatItValidatesLowercaseAlphaText {
    NSString *text = @"abcd";
    XCTAssertTrue([self.sut validate:text error:nil]);
}

- (void)testThatItValidatesUppercaseAlphaText {
    NSString *text = @"ABCD";
    XCTAssertTrue([self.sut validate:text error:nil]);
}

- (void)testThatItValidatesMixedAlphaText {
    NSString *text = @"AbC";
    XCTAssertTrue([self.sut validate:text error:nil]);
}

- (void)testThatItDoesNotValidateTextWithoutAlphaCharacters {
    NSString *text = @"123";
    XCTAssertFalse([self.sut validate:text error:nil]);
}

- (void)testThatItDoesNotValidateTextWithAlphaAndNumbericCharacters {
    NSString *text = @"AbC123";
    XCTAssertFalse([self.sut validate:text error:nil]);
}

- (void)testThatItReturnsAnDefaultErrorIfValidationFails {
    NSString *text = @"AbC123";
    NSError *error = nil;
    [self.sut validate:text error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertTrue(error.code == LKValidatorAlphaErrorCode);
}

@end
