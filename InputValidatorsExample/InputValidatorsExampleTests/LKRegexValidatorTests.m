//
//  LKRegexValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 02/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKRegexValidator.h"

@interface LKRegexValidatorTests : XCTestCase

@property (nonatomic, strong) LKRegexValidator *sut;

@end

@implementation LKRegexValidatorTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKRegexValidator validator];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItHasADefaultError {
    XCTAssertTrue(self.sut.error.code == LKValidatorRegexErrorCode);
}

- (void)testThatItDoesNotHaveARegex {
    XCTAssertNil(self.sut.regex);
}

- (void)testThatItReturnsErrorIfTextHasZeroLength {
    NSError *error = nil;
    BOOL result = [self.sut validate:@"" error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertFalse(result);
}

- (void)testThatItDoesValidateIfRegexNotSet {
    NSError *error = nil;
    BOOL result = [self.sut validate:@"text" error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertFalse(result);
}

- (void)testThatItValidatesIfRegexIsSetAndTextIsValid {
    self.sut.regex = @"^[a-zA-Z]*$";

    NSError *error = nil;
    BOOL result = [self.sut validate:@"text" error:&error];
    
    XCTAssertNil(error);
    XCTAssertTrue(result);
}

- (void)testThatItDoesNotValidateIfRegexIsSetButTextIsNotValid {
    self.sut.regex = @"^[a-zA-Z]*$";
    
    NSError *error = nil;
    BOOL result = [self.sut validate:@"text123" error:&error];
    
    XCTAssertNotNil(error);
    XCTAssertFalse(result);
}

@end
