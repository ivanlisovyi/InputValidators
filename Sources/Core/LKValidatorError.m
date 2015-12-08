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

#import "LKValidatorError.h"

NSString * const LKValidatorErrorDomain = @"InputValidationErrorDomain";

@implementation LKValidatorError

+ (instancetype)unknownValidationError {
    return [self errorWithCode:LKValidatorUnknownErrorCode];
}

+ (instancetype)numericValidationError {
    return [self errorWithCode:LKValidatorNumericErrorCode];
}

+ (instancetype)alphaValidationError {
    return [self errorWithCode:LKValidatorAlphaErrorCode];
}

+ (instancetype)emailValidationError {
    return [self errorWithCode:LKValidatorEmailErrorCode];
}

+ (instancetype)requiredValidationError {
    return [self errorWithCode:LKValidatorRequiredErrorCode];
}

+ (instancetype)lengthValidationError {
    return [self errorWithCode:LKValidatorLengthErrorCode];
}

+ (instancetype)regexValidationError {
    return [self errorWithCode:LKValidatorRegexErrorCode];
}

+ (instancetype)multipleValidationError {
    return [self errorWithCode:LKValidatorMultipleErrorCode];
}

+ (instancetype)multipleValidationErrorWithErrors:(NSArray<LKValidatorError *> *)errors {
    NSMutableString *result = [NSMutableString string];
    for (LKValidatorError *error in errors) {
        NSString *reason = [error localizedFailureReason];
        [result appendFormat:@"%@\n", reason];
    }
    
    if (result.length > 0) {
        NSCharacterSet *characterSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        result = [[result stringByTrimmingCharactersInSet:characterSet] copy];
    }
    
    return [self errorWithCode:LKValidatorMultipleErrorCode reason:result];
}

+ (instancetype)errorWithCode:(LKValidatorErrorCode)code {
    NSString *defaultReason = [self localizedReasonForErrorCode:code];
    return [self errorWithCode:code reason:defaultReason];
}

+ (instancetype)errorWithCode:(LKValidatorErrorCode)code reason:(NSString *)reason {
    NSDictionary *userInfo = nil;
    if (reason) {
        userInfo = @{NSLocalizedFailureReasonErrorKey: reason};
    }
    
    return [self errorWithDomain:LKValidatorErrorDomain code:code userInfo:userInfo];
}

#pragma mark - Private

+ (NSString *)localizedReasonForErrorCode:(LKValidatorErrorCode)code {
    switch (code) {
        case LKValidatorNumericErrorCode:
            return NSLocalizedString(@"The string can contain only numerical values.", nil);
            
        case LKValidatorAlphaErrorCode:
            return NSLocalizedString(@"The string can contain only letters.", nil);
            
        case LKValidatorEmailErrorCode:
            return NSLocalizedString(@"The string isn't a valid email.", nil);
            
        case LKValidatorRequiredErrorCode:
            return NSLocalizedString(@"The string can't be empty.", nil);
            
        case LKValidatorLengthErrorCode:
            return NSLocalizedString(@"The string length isn't valid.", nil);
            
        case LKValidatorUnknownErrorCode:
        case LKValidatorMultipleErrorCode:
        case LKValidatorRegexErrorCode:
        default:
            return NSLocalizedString(@"The string isn't valid.", nil);
    }
}

@end
