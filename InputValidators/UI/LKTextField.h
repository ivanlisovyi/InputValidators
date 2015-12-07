// The MIT License (MIT)
//
// Copyright (c) 2015 Ivan Lisovyi
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

NS_ASSUME_NONNULL_BEGIN

@class LKValidator;

@interface LKTextField : UITextField

@property (nonatomic, assign, readonly, getter=isValid) BOOL valid;

@property (nonatomic, strong, readonly) NSArray<LKValidator *> *validators;
@property (nonatomic, strong, readonly) NSArray<LKTextField *> *dependencies;
@property (nonatomic, strong, readonly) NSArray<LKTextField *> *dependents;

- (BOOL)validateWithDependencies:(NSError **)error;
- (BOOL)validate:(NSError **)error;

- (BOOL)containsValidator:(LKValidator *)validator;;

- (void)addValidator:(LKValidator *)validator;
- (void)removeValidator:(LKValidator *)validator;
- (void)removeAllValidators;

- (void)addDependency:(LKTextField *)textField;
- (void)removeDependency:(LKTextField *)textField;
- (void)removeAllDependencies;

- (void)addDependent:(LKTextField *)textField;
- (void)removeDependent:(LKTextField *)textField;
- (void)removeAllDependents;

@end

NS_ASSUME_NONNULL_END
