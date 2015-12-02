// The MIT License (MIT)
//
// Copyright (c) 2015 Ivan Lisovyi, Denis Kotenko
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

#import "LKRegexValidator.h"

@implementation LKRegexValidator

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.error = [LKValidatorError regexValidationError];
    }
    
    return self;
}

#pragma mark - Validation

- (BOOL)validate:(NSString *)string error:(NSError **)error {
    BOOL validationRequired = (string && string.length != 0 && self.regex);
    if (validationRequired) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex];
        BOOL valid = [predicate evaluateWithObject:string];
        
        if (!valid) {
            if (error) {
                *error = self.error;
            }
        }
        
        return valid;
    }
    
    return [super validate:string error:error];
}

@end
