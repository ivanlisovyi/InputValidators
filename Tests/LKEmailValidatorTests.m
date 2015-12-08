//
//  LKEmailValidatorTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 05/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKEmailValidator.h"

@interface LKEmailValidatorTests : XCTestCase

@property (nonatomic, strong) LKEmailValidator *sut;

@end

@implementation LKEmailValidatorTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKEmailValidator validator];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testThatItHasADefaultError {
    XCTAssertTrue(self.sut.error.code == LKValidatorEmailErrorCode);
}

- (void)testThatItValidatesIfTextIsEmail {
    XCTAssertTrue([self.sut validate:@"test@email.com" error:nil]);
}

- (void)testThtaItValidatesWithMultipleDotsInEmail {
    XCTAssertTrue([self.sut validate:@"test.part.one@email.com" error:nil]);
}

- (void)testThatItValidatesWithPlusSignInEmails {
    XCTAssertTrue([self.sut validate:@"test+partone@email.com" error:nil]);
}

- (void)testThatItDoesNotValidateIfAtIsMissing {
    XCTAssertFalse([self.sut validate:@"testemail.com" error:nil]);
}

- (void)testThatItDoesNotValidateIfEmailPartIsEmpty {
    XCTAssertFalse([self.sut validate:@"@email.com" error:nil]);
}

- (void)testThatItDoesNotValidateIfEmailDoeNotHaveADomain {
    XCTAssertFalse([self.sut validate:@"test@email" error:nil]);
}

- (void)testThatItDoesNotValidateIfDomainLengthIsLessThanTwo {
    XCTAssertFalse([self.sut validate:@"test@email.c" error:nil]);
}

- (void)testThatItDoesNotValidateIfSpecialSymbolsUsed {
    XCTAssertFalse([self.sut validate:@"test%&*w@email.com" error:nil]);
}

- (void)testThatItDoesNotValidateWithLeadingSpace {
    XCTAssertFalse([self.sut validate:@"test@email.com " error:nil]);
}

- (void)testThatItDoesNotValidateWithTrailingSpace {
    XCTAssertFalse([self.sut validate:@" test@email.com" error:nil]);
}

@end
