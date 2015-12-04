//
//  LKMultipleValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 04/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKMultipleValidator.h"
#import "LKRequiredValidator.h"
#import "LKNumericValidator.h"

@interface LKMultipleValidatorTests : XCTestCase

@property (nonatomic, strong) LKMultipleValidator *sut;

@end

@implementation LKMultipleValidatorTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKMultipleValidator validator];
    self.sut.validators = @[[LKRequiredValidator validator], [LKNumericValidator validator]];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItHasADefaultError {
    XCTAssertTrue(self.sut.error.code == LKValidatorMultipleErrorCode);
}

- (void)testThatItHasValidatorsAfterTheyHaveBeenSet {
    XCTAssertNotNil(self.sut.validators);
}

- (void)testThatItDoesNotValidateIfValidatorsNotSet {
    NSArray *validators = nil;
    self.sut.validators = validators;
    
    XCTAssertFalse([self.sut validate:@"123" error:nil]);
}

- (void)testThatItDoesNotValidateIfValidatorsArrayIsEmpty {
    self.sut.validators = @[];
    
    XCTAssertFalse([self.sut validate:@"123" error:nil]);
}

- (void)testThatItValidatesCorrectlyIfTextIsCorrect {
    XCTAssertTrue([self.sut validate:@"123" error:nil]);
}

- (void)testThatItDoesNotValidateIfTextIsNotCorrect {
    XCTAssertFalse([self.sut validate:@"123A" error:nil]);
}

- (void)testThatItReturnACompoundErrorIfValidationFails {
    NSError *error = nil;
    [self.sut validate:@"" error:&error];
    
    XCTAssertNotNil(error);
}

@end
