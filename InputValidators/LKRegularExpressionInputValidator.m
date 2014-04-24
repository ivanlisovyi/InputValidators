// The MIT License (MIT)
//
// Copyright (c) 2013 Ivan Lisovoy, Denis Kotenko
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

#import "LKRegularExpressionInputValidator.h"
#import "LKRequiredInputValidator.h"


@implementation LKRegularExpressionInputValidator

#pragma mark -
#pragma mark Validation

- (BOOL) validateInput:(NSString *)input error:(NSError **)error {
    NSRegularExpression *regex = [NSRegularExpression
        regularExpressionWithPattern:_regularExpression
        options:NSRegularExpressionAnchorsMatchLines error:error];
    
    if ([input length] == 0) {
        if (error != nil) {
            NSString *theReason = NSLocalizedString(@"The text field doesn't contain any characters, can't validate", @"Validator reason (Alert)");
            *error = [[self class] errorWithReason:theReason code:InputValidationRequiredErrorCode];
        }
        return NO;
    }
    
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:input
                                                        options:NSMatchingAnchored
                                                          range:NSMakeRange(0, [input length])];
    
    if (numberOfMatches == 0) {
        if (error != nil) {
            *error = [self error];
        }
        
        return NO;
    }
    
    return YES;
}

- (NSError *) error {
    return [[self class] errorWithReason:self.reason code:_errorCode];
}


@end
