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

#import "LKMultipleValidator.h"

@implementation LKMultipleValidator

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.error = [LKValidatorError multipleValidationError];
        _validators = @[];
    }
    
    return self;
}

#pragma mark - Validation

- (BOOL)validate:(NSString *)string error:(NSError **)error {
    if (!self.validators || self.validators.count == 0) {
        return [super validate:string error:error];
    }
    
    NSMutableArray *errors = [NSMutableArray array];
    for (LKValidator *validator in self.validators) {
        NSError *error = nil;
        [validator validate:string error:&error];
    
        if (error) {
            [errors addObject:error];
        }
    }

    BOOL isValid = [errors count] == 0;
    if (!isValid && error) {
        *error = [LKValidatorError multipleValidationErrorWithErrors:errors];
    }

    return isValid;
}

@end
