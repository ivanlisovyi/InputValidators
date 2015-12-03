//
//  LKLengthValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 03/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKLengthValidator.h"

@interface LKLengthValidatorTests : XCTestCase

@property (nonatomic, strong) LKLengthValidator *sut;

@end

@implementation LKLengthValidatorTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKLengthValidator validator];
    self.sut.length = 5;
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItHasADefaultError {
    XCTAssertTrue(self.sut.error.code == LKValidatorLengthErrorCode);
}

- (void)testThatItDoesNotValidateIfLengthIsLessThatRequired {
    XCTAssertFalse([self.sut validate:@"1234" error:nil]);
}

- (void)testThatItValidatesIfLengthIsSameAsRequired {
    XCTAssertTrue([self.sut validate:@"12345" error:nil]);
}

- (void)testThatItValidatesIfLengthIsGreaterThatRequired {
    XCTAssertTrue([self.sut validate:@"123456" error:nil]);
}

@end
