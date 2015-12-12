//
//  LKTextFieldTests.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 05/12/2015.
//  Copyright © 2015 Ivan Lisovyi. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "LKTextField.h"

#import "LKRequiredValidator.h"
#import "LKAlphaValidator.h"
#import "LKNumericValidator.h"

@interface LKTextFieldTests : XCTestCase

@property (nonatomic, strong) LKTextField *sut;

@end

@implementation LKTextFieldTests

- (void)setUp {
    [super setUp];
    
    self.sut = [LKTextField new];
}

- (void)tearDown {
    [super tearDown];
    
    [self.sut removeAllValidators];
    [self.sut removeAllDependencies];
    [self.sut removeAllDependents];
}

- (void)testThatItDoesNotHaveValidatorsByDefault {
    XCTAssert(self.sut.validators.count == 0);
}

- (void)testThatItDoesNothHaveDependenciesByDefault {
    XCTAssert(self.sut.dependencies.count == 0);
}

- (void)testThatItDoesNotHaveDependentsByDefault {
    XCTAssert(self.sut.dependents.count == 0);
}

#pragma mark - Validators

- (void)testThatItsPossibleToAddValidator {
    [self.sut addValidator:[LKRequiredValidator validator]];
    
    XCTAssert(self.sut.validators.count == 1);
}

- (void)testThatItThrowsWhenAddsNilToValidators {
    LKValidator *validator = nil;
    
    XCTAssertNoThrow([self.sut addValidator:validator]);
}

- (void)testThatItDoesNotAddTheSameValidator {
    LKValidator *validator = [LKRequiredValidator validator];
    LKValidator *validator2 = validator;
    
    [self.sut addValidator:validator];
    [self.sut addValidator:validator2];
    
    XCTAssert(self.sut.validators.count == 1);
}

- (void)testThatItsPossibleToRemoveValidator {
    LKValidator *validator = [LKRequiredValidator validator];
    
    [self.sut addValidator:validator];
    
    XCTAssert(self.sut.validators.count == 1);
    
    [self.sut removeValidator:validator];
    
    XCTAssert(self.sut.validators.count == 0);
}

- (void)testThatItDoesNotThrowIfRemovesNilValidator {
    LKValidator *validator = nil;

    XCTAssertNoThrow([self.sut removeValidator:validator]);
}

- (void)testThatItRemovesAllValidators {
    LKValidator *validator = [LKRequiredValidator validator];
    LKValidator *validator2 = [LKAlphaValidator validator];
    
    [self.sut addValidator:validator];
    [self.sut addValidator:validator2];
    
    XCTAssert(self.sut.validators.count == 2);
    
    [self.sut removeAllValidators];
    
    XCTAssert(self.sut.validators.count == 0);
}

#pragma mark - Dependencies

- (void)testThatItAddsDependency {
    LKTextField *dependency = [LKTextField new];
    
    [self.sut addDependency:dependency];
    
    XCTAssert(self.sut.dependencies.count == 1);
}

- (void)testThatItDoesNotToAddTheSameDependencyTwice {
    LKTextField *dependency = [LKTextField new];
    LKTextField *dependency2 = dependency;
    
    [self.sut addDependency:dependency];
    [self.sut addDependency:dependency2];
    
    XCTAssert(self.sut.dependencies.count == 1);
}

- (void)testThatItDoesNotAddDependencyIfTargesIsDependant {
    LKTextField *dependency = [LKTextField new];
    [dependency addDependency:self.sut];
    
    [self.sut addDependency:dependency];
    
    XCTAssert(self.sut.dependencies.count == 0);
}

- (void)testThatItDoesNotAddDependencyIfDependencyIsNil {
    LKTextField *dependency = nil;
    
    [self.sut addDependency:dependency];
    
    XCTAssert(self.sut.dependencies.count == 0);
}

- (void)testThatItRemovesDependecy {
    LKTextField *dependency = [LKTextField new];
    [self.sut addDependency:dependency];
    
    XCTAssert(self.sut.dependencies.count == 1);
    
    [self.sut removeDependency:dependency];
    
    XCTAssert(self.sut.dependencies.count == 0);
}

- (void)testThatItRemovesAllDependencies {
    LKTextField *textField = [LKTextField new];
    LKTextField *textField2 = [LKTextField new];
    
    [self.sut addDependency:textField];
    [self.sut addDependency:textField2];
    
    XCTAssert(self.sut.dependencies.count == 2);
    
    [self.sut removeAllDependencies];
    
    XCTAssert(self.sut.dependencies.count == 0);
}

#pragma mark - Dependents

- (void)testThatItAddsDependent {
    LKTextField *dependent = [LKTextField new];
    
    [self.sut addDependent:dependent];
    
    XCTAssert(self.sut.dependents.count == 1);
}

- (void)testThatIdDoesNotAddTheSameDependentTwice {
    LKTextField *dependent = [LKTextField new];
    LKTextField *dependent2 = dependent;
    
    [self.sut addDependent:dependent];
    [self.sut addDependent:dependent2];
    
    XCTAssert(self.sut.dependents.count == 1);
}

- (void)testThatItDoesNotAddNilToDependants {
    LKTextField *dependant = nil;
    
    XCTAssertNoThrow([self.sut addDependent:dependant]);
    XCTAssert(self.sut.dependents.count == 0);
}

- (void)testThatItRemovesDependent {
    LKTextField *dependent = [LKTextField new];
    
    [self.sut addDependent:dependent];
    
    XCTAssert(self.sut.dependents.count == 1);
    
    [self.sut removeDependent:dependent];
    
    XCTAssert(self.sut.dependents.count == 0);
}

- (void)testThatItRemovesAllDependents {
    LKTextField *textField = [LKTextField new];
    LKTextField *textField2 = [LKTextField new];
    
    [self.sut addDependent:textField];
    [self.sut addDependent:textField2];
    
    XCTAssert(self.sut.dependents.count == 2);
    
    [self.sut removeAllDependents];
    
    XCTAssert(self.sut.dependents.count == 0);
}

#pragma mark - Validation

- (void)testThatItValidatesCorrectlyUsingValidators {
    LKValidator *validator = [LKRequiredValidator validator];
    LKValidator *validator2 = [LKAlphaValidator validator];
    
    [self.sut addValidator:validator];
    [self.sut addValidator:validator2];
    
    self.sut.text = @"valid";
    
    XCTAssertTrue([self.sut validate:nil]);
}

- (void)testThatItValidatesAndReturnsFalseIfTextIsNotValid {
    LKValidator *validator = [LKRequiredValidator validator];
    LKValidator *validator2 = [LKAlphaValidator validator];
    
    [self.sut addValidator:validator];
    [self.sut addValidator:validator2];
    
    self.sut.text = @"notvalid1";

    XCTAssertFalse([self.sut validate:nil]);
}

- (void)testThatItValidatesWithDependencies {
    LKValidator *validator = [LKAlphaValidator validator];
    
    [self.sut addValidator:validator];
    self.sut.text = @"valid";
    
    LKTextField *dependency = [LKTextField new];
    dependency.text = @"validtoo";
    [dependency addValidator:validator];
    
    [self.sut addDependency:dependency];
    
    XCTAssertTrue([self.sut validateWithDependencies:nil]);
}

- (void)testThatItValidatesWithDependenciesAndReturnsFalseIfDependencyIsNotValid {
    LKValidator *validator = [LKAlphaValidator validator];
    
    [self.sut addValidator:validator];
    self.sut.text = @"valid";
    
    LKTextField *dependency = [LKTextField new];
    dependency.text = @"not_valida_1";
    [dependency addValidator:validator];
    
    [self.sut addDependency:dependency];
    
    LKTextField *dependency2 = [LKTextField new];
    dependency.text = @"123";
    [dependency addValidator:[LKNumericValidator validator]];
    
    [self.sut addDependency:dependency2];
    
    XCTAssertFalse([self.sut validateWithDependencies:nil]);
}

@end
