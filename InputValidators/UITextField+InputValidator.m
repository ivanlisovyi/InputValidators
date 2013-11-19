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

#import <objc/runtime.h>
#import "UITextField+InputValidator.h"

NSString *const UITextFieldInvalidDependencyException = @"UITextFieldInvalidDependencyException";

@implementation UITextField (InputValidator)

- (void) addDependency:(UITextField *) textField {
    NSParameterAssert(textField);
    
    if ([self _dependencies] == nil) {
        [self _setDependencies:[NSMutableArray array]];
    }
    
    if ([[self _dependencies] containsObject:textField]) {
        return;
    }
    
    if ([[textField dependencies] containsObject:self]) {
        @throw [NSException exceptionWithName:UITextFieldInvalidDependencyException reason:nil userInfo:nil];
    }
    
    [[self _dependencies] addObject:textField];
    [textField addDependent:self];
}

- (void) removeDependency:(UITextField *) textField {
    [[self _dependencies] removeObject:textField];
    [textField removeDependent:self];
}

- (void) removeAllDependencies {
    [[self _dependencies] makeObjectsPerformSelector:@selector(removeDependent:) withObject:self];
    [[self _dependencies] removeAllObjects];
}

- (NSArray *) dependencies {
    if ([self _dependencies] == nil) {
        return nil;
    }
    
    NSMutableArray *allDependencies = [NSMutableArray array];
    for (UITextField *textField in [self _dependencies]) {
        [allDependencies addObjectsFromArray:[textField dependencies]];
    }
    [allDependencies addObjectsFromArray:[self _dependencies]];
    return allDependencies;
}

- (NSMutableArray *) _dependencies {
    return [self associatedObjectForKey:@"_dependencies"];
}

- (void) _setDependencies:(NSMutableArray *) dependencies {
    [self setAssociatedObject:dependencies forKey:@"_dependencies"];
}

- (void) addDependent:(UITextField *) textField {
    NSParameterAssert(textField);
    
    if ([self _dependents] == nil) {
        [self _setDependents:[NSMutableArray array]];
    }
    
    if ([[self _dependents] containsObject:textField]) {
        return;
    }
    [[self _dependents] addObject:textField];
}

- (void) removeDependent:(UITextField *) textField {
    [[self _dependents] removeObject:textField];
}

- (void) removeAllDependents {
    [[self _dependents] removeAllObjects];
}

- (NSArray *) dependents {
    return [NSArray arrayWithArray:[self _dependents]];
}

- (NSMutableArray *) _dependents {
    return [self associatedObjectForKey:@"_dependents"];
}

- (void) _setDependents:(NSMutableArray *) dependents {
    [self setAssociatedObject:dependents forKey:@"_dependents"];
}

- (void) addValidator:(InputValidator *) aValidator {
    NSParameterAssert(aValidator);
    
    if ([self _validators] == nil) {
        [self _setValidators:[NSMutableArray array]];
    }
    
    if ([self containsValidator:aValidator]) {
        return;
    }
    [[self _validators] addObject:aValidator];
}

- (BOOL) containsValidator:(InputValidator *) aValidator {
    return [[self _validators] containsObject:aValidator];
}

- (NSMutableArray *) _validators {
    return [self associatedObjectForKey:@"_validators"];
}

- (void) _setValidators:(NSMutableArray *) validators {
    [self setAssociatedObject:validators forKey:@"_validators"];
}

- (void) removeValidator:(InputValidator *) aValidator {
    [[self _validators] removeObject:aValidator];
}

- (void) removeAllValidators {
    [[self _validators] removeAllObjects];
}

- (NSArray *) validators {
    return [NSArray arrayWithArray:[self _validators]];
}

- (BOOL) isValid {
    return [[self associatedObjectForKey:@"_isValid"] boolValue];
}

- (void) setIsValid:(BOOL) isValid {
    [self setAssociatedObject:@(isValid) forKey:@"_isValid"];
}

- (void) validateWithDependencies:(NSError **)error {
    NSArray *array = [self dependencies];
    BOOL isDependeciesValid = YES;
    
    for (UITextField *textField in array) {
        BOOL isValid = [textField validate:error];
        
        if (!isValid) {
            isDependeciesValid = NO;
            [self setIsValid:NO];
            break;
        }
    }
    
    if (isDependeciesValid) {
        [self validate:error];
    }
}

- (BOOL) validate:(NSError **)error {
    NSArray *validators = [self _validators];
    BOOL isValid = [InputValidator validateInput:self.text validators:validators error:error];
    
    [self setIsValid:isValid];
    
    return isValid;
}

#pragma mark -
#pragma mark runtime association

- (id) associatedObjectForKey:(NSString *) aKey {
    return objc_getAssociatedObject(self, (__bridge const void *) (aKey));
}

- (void) setAssociatedObject:(id) anObject forKey:(NSString *) aKey {
    objc_setAssociatedObject(self, (__bridge const void *) (aKey), anObject, OBJC_ASSOCIATION_RETAIN);
}

- (void) removeAssociatedObjects {
    objc_removeAssociatedObjects(self);
}

@end
