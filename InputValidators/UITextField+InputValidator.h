// The MIT License (MIT)
//
// Copyright (c) 2013 Lisovoy Ivan, Denis Kotenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

#import "RequiredInputValidator.h"
#import "NumericInputValidator.h"
#import "AlphaInputValidator.h"
#import "EmailInputValidator.h"

extern NSString *const UITextFieldInvalidDependencyException;

@interface UITextField (InputValidator)

- (BOOL) containsValidator:(InputValidator *) aValidator;

- (void) addValidator:(InputValidator *) aValidator;
- (void) removeValidator:(InputValidator *) aValidator;
- (void) removeAllValidators;
- (NSArray *) validators;

- (void) validateWithDependencies:(NSError **)error;
- (BOOL) validate:(NSError **)error;

- (void) addDependency:(UITextField *) textField;
- (void) removeDependency:(UITextField *) textField;
- (void) removeAllDependencies;
- (NSMutableArray *) dependencies;

- (void) addDependent:(UITextField *) textField;
- (void) removeDependent:(UITextField *) textField;
- (void) removeAllDependents;
- (NSArray *) dependents;

@end
