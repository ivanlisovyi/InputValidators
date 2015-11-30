//
//  LKValidatorErrorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 30/11/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKValidatorError.h"

@interface LKValidatorErrorTests : XCTestCase

@end

@implementation LKValidatorErrorTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItCanInstanceErrorWithErrorCode {
    LKValidatorErrorCode expected = LKValidatorAlphaErrorCode;
    
    LKValidatorError *error = [LKValidatorError errorWithCode:LKValidatorAlphaErrorCode];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatItHasADefaultReasonForErrorCode {
    LKValidatorError *error = [LKValidatorError errorWithCode:LKValidatorNumericErrorCode];
    XCTAssertNotNil(error.userInfo[NSLocalizedFailureReasonErrorKey]);
}

- (void)testThatItCanInstanceErrorWithCodeAndReason {
    LKValidatorErrorCode expectedCode = LKValidatorRequiredErrorCode;
    NSString *expectedReason = @"A Reason";
    
    LKValidatorError *error = [LKValidatorError errorWithCode:expectedCode reason:expectedReason];
    XCTAssertTrue(error.code == expectedCode);
    XCTAssertTrue([error.userInfo[NSLocalizedFailureReasonErrorKey] isEqualToString:expectedReason]);
}

- (void)testThatInCanInstanceUnknownError {
    LKValidatorErrorCode expected = LKValidatorUnknownErrorCode;
    
    LKValidatorError *error = [LKValidatorError unknownValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatInCanInstanceNumericError {
    LKValidatorErrorCode expected = LKValidatorNumericErrorCode;
    
    LKValidatorError *error = [LKValidatorError numericValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatInCanInstanceAlphaError {
    LKValidatorErrorCode expected = LKValidatorAlphaErrorCode;
    
    LKValidatorError *error = [LKValidatorError alphaValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatInCanInstanceEmailError {
    LKValidatorErrorCode expected = LKValidatorEmailErrorCode;
    
    LKValidatorError *error = [LKValidatorError emailValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatInCanInstanceRequiredError {
    LKValidatorErrorCode expected = LKValidatorRequiredErrorCode;
    
    LKValidatorError *error = [LKValidatorError requiredValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatInCanInstanceLengthError {
    LKValidatorErrorCode expected = LKValidatorLengthErrorCode;
    
    LKValidatorError *error = [LKValidatorError lengthValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatInCanInstanceRegexError {
    LKValidatorErrorCode expected = LKValidatorRegexErrorCode;
    
    LKValidatorError *error = [LKValidatorError regexValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatInCanInstanceMultipleError {
    LKValidatorErrorCode expected = LKValidatorMultipleErrorCode;
    
    LKValidatorError *error = [LKValidatorError multipleValidationError];
    XCTAssertTrue(error.code == expected);
}

- (void)testThatItCanInstanceMultipleErrorFromArrayOfErrors {
    LKValidatorErrorCode expectedCode = LKValidatorMultipleErrorCode;
    
    LKValidatorError *alphaError = [LKValidatorError alphaValidationError];
    LKValidatorError *numericalError = [LKValidatorError numericValidationError];
    
    NSString *alphaReason = alphaError.userInfo[NSLocalizedFailureReasonErrorKey];
    NSString *numericalReason = numericalError.userInfo[NSLocalizedFailureReasonErrorKey];
    NSString *expectedReason = [NSString stringWithFormat:@"%@\n%@", alphaReason, numericalReason];
    
    LKValidatorError *error = [LKValidatorError multipleValidationErrorWithErrors:@[alphaError, numericalError]];
    
    XCTAssertTrue(error.code == expectedCode);
    XCTAssertTrue([error.userInfo[NSLocalizedFailureReasonErrorKey] isEqualToString:expectedReason]);
}

@end
