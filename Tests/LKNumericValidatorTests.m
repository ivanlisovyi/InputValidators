//
//  LKNumericValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 02/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKNumericValidator.h"

@interface LKNumericValidatorTests : XCTestCase

@property (nonatomic, strong) LKNumericValidator *sut;

@end

@implementation LKNumericValidatorTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKNumericValidator validator];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItHasADefaultError {
    XCTAssertTrue(self.sut.error.code == LKValidatorNumericErrorCode);
}

- (void)testThatItValidatesNumericString {
    NSString *text = @"123";
    XCTAssertTrue([self.sut validate:text error:nil]);
}

- (void)testThatItDoesNotValidateTextNumericCharacters {
    NSString *text = @"ABC";
    XCTAssertFalse([self.sut validate:text error:nil]);
}

- (void)testThatItDoesNotValidateTextWithAlphaAndNumbericCharacters {
    NSString *text = @"AbC123";
    XCTAssertFalse([self.sut validate:text error:nil]);
}

@end
