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

#import "InputValidator.h"
#import "NumericInputValidator.h"
#import "AlphaInputValidator.h"
#import "EmailInputValidator.h"
#import "RequiredInputValidator.h"

@implementation InputValidator

#pragma mark -

+ (instancetype) numericValidator {
    return [[NumericInputValidator alloc] init];
}

+ (instancetype) alphaValidator {
    return [[AlphaInputValidator alloc] init];
}

+ (instancetype) emailValidator {
    return [[EmailInputValidator alloc] init];
}

+ (instancetype) requiredValidator {
    return [[RequiredInputValidator alloc] init];
}

#pragma mark -
#pragma mark Validation

+ (BOOL) validateInput:(NSString *)input validators:(NSArray *)validators error:(NSError **)error {
    NSMutableArray *errors = [NSMutableArray array];
    for (InputValidator *validator in validators) {
        NSError *error = nil;
        BOOL isValid = [validator validateInput:input error:&error];
        
        
        if (!isValid) {
            [errors addObject:error];
        }
    }
    
    BOOL isValid = [errors count] == 0;
    
    if (!isValid) {
        NSMutableString *errorMessage = [NSMutableString string];
        for (NSError *error in errors) {
            [errorMessage appendFormat:@"%@\n", [error localizedFailureReason]];
        }
        [errorMessage deleteCharactersInRange:NSMakeRange([errorMessage length] - 1, 1)];
        
        *error = [[self class] errorWithReason:errorMessage code:InputValidationMultipleErrorCode];
    }
    
    return isValid;
}

- (BOOL) validateInput:(NSString *)input error:(NSError **)error {
    if (error) {
        *error = nil; 
    }
    
    return NO;
}

+ (NSError *) errorWithReason:(NSString *)aReason code:(NSInteger)code {
    NSString *description = NSLocalizedString(@"Input Validation Failed", @"Input Validation Failed");
    NSDictionary *userInfo =  @{NSLocalizedDescriptionKey : description,
                                NSLocalizedFailureReasonErrorKey : aReason};

    NSError *error = [NSError errorWithDomain:InputValidationErrorDomain code:code userInfo:userInfo];
    return error;
}

@end
