//
//  LKRequiredValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 02/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKRequiredValidator.h"

@interface LKRequiredValidatorTests : XCTestCase

@property (nonatomic, strong) LKRequiredValidator *sut;

@end

@implementation LKRequiredValidatorTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKRequiredValidator validator];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItHasADefaultError {
    XCTAssertTrue(self.sut.error.code == LKValidatorRequiredErrorCode);
}

- (void)testThatItValidatesNotEmptyString {
    XCTAssertTrue([self.sut validate:@"not empty" error:nil]);
}

- (void)testThatItDoesNotValidateEmptyString {
    XCTAssertFalse([self.sut validate:@"" error:nil]);
}

@end
