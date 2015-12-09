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

#import "LKTextField.h"

#import "LKMultipleValidator.h"

@interface LKTextField ()

@property (nonatomic, assign, readwrite, getter=isValid) BOOL valid;

@property (nonatomic, strong, readwrite) NSArray<LKValidator *> *validators;
@property (nonatomic, strong) NSHashTable<LKTextField *> *dependenciesTable;
@property (nonatomic, strong) NSHashTable<LKTextField *> *dependentsTable;

@end

@implementation LKTextField

- (BOOL)validateWithDependencies:(NSError **)error {
    NSArray *dependencies = [self dependencies];
    BOOL isDependeciesValid = YES;
    
    for (LKTextField *textField in dependencies) {
        BOOL isValid = [textField validate:error];
        
        if (!isValid) {
            isDependeciesValid = NO;
            self.valid = NO;
            
            break;
        }
    }
    
    BOOL valid = NO;
    if (isDependeciesValid) {
         valid = [self validate:error];
    }
    
    return isDependeciesValid && valid;
}

- (BOOL)validate:(NSError **)error {
    LKMultipleValidator *validator = [LKMultipleValidator validator];
    validator.validators = self.validators;
    
    return [validator validate:self.text error:error];
}

#pragma mark - Validators

- (void)addValidator:(LKValidator *)validator {
    if (!validator) {
        return;
    }
    
    if ([self containsValidator:validator]) {
        return;
    }
    
    NSMutableArray *validators = [self.validators mutableCopy];
    [validators addObject:validator];
    
    self.validators = [validators copy];
}

- (void)removeValidator:(LKValidator *)validator {
    NSMutableArray *validators = [self.validators mutableCopy];
    [validators removeObject:validator];
    
    self.validators = [validators copy];
}

- (void)removeAllValidators {
    self.validators = @[];
}

- (BOOL)containsValidator:(LKValidator *)validator {
    return [self.validators containsObject:validator];
}

#pragma mark - Dependencies

- (NSArray<LKTextField *> *)dependencies {
    return [self.dependenciesTable allObjects];
}

- (void)addDependency:(LKTextField *)textField {
    if (!textField) {
        return;
    }
    
    if ([self.dependenciesTable containsObject:textField]) {
        return;
    }
    
    if ([textField.dependenciesTable containsObject:self]) {
        return;
    }
    
    [self.dependenciesTable addObject:textField];
    [textField addDependent:self];
}

- (void)removeDependency:(LKTextField *)textField {
    [self.dependenciesTable removeObject:textField];
    [textField removeDependent:self];
}

- (void)removeAllDependencies {
    [self.dependencies makeObjectsPerformSelector:@selector(removeDependent:) withObject:self];
    [self.dependenciesTable removeAllObjects];
}

#pragma mark - Dependents

- (NSArray<LKTextField *> *)dependents {
    return [self.dependentsTable allObjects];
}

- (void)addDependent:(LKTextField *)textField {
    if (!textField) {
        return;
    }
    
    if ([self.dependentsTable containsObject:textField]) {
        return;
    }
    
    [self.dependentsTable addObject:textField];
}

- (void)removeDependent:(LKTextField *)textField {
    [self.dependentsTable removeObject:textField];
}

- (void)removeAllDependents {
    [self.dependentsTable removeAllObjects];
}

#pragma mark - Private Properties

- (NSArray<LKValidator *> *)validators {
    if (!_validators) {
        _validators = [NSArray array];
    }
    
    return _validators;
}

- (NSHashTable<LKTextField *> *)dependenciesTable {
    if (!_dependenciesTable) {
        _dependenciesTable = [NSHashTable weakObjectsHashTable];
    }
    
    return _dependenciesTable;
}

- (NSHashTable<LKTextField *> *)dependentsTable {
    if (!_dependentsTable) {
        _dependentsTable = [NSHashTable weakObjectsHashTable];
    }
    
    return _dependentsTable;
}

@end
