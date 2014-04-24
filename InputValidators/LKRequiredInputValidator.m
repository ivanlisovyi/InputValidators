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

#import "LKRequiredInputValidator.h"

@implementation LKRequiredInputValidator

- (id) init {
    self = [super init];
    
    if (self) {
        self.reason = NSLocalizedString(@"The text field can't not be empty.", @"Validator reason (Alert)");
    }
    
    return self;
}

- (BOOL) validateInput:(NSString *)input error:(NSError **) error {
    NSString *text = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([text length] == 0) {
        if (error != nil) {
            *error = [[self class] errorWithReason:self.reason code:InputValidationRequiredErrorCode];
        }
        return NO;
    }
    return YES;
}

@end
