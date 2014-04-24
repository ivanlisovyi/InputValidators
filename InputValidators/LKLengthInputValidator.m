//
//  LKLengthInputValidator.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 24.04.14.
//  Copyright (c) 2014 Ramotion. All rights reserved.
//

#import "LKLengthInputValidator.h"

static NSUInteger const kKLValidatorDefaultMinLength = 5;

@implementation LKLengthInputValidator

- (id) init {
    self = [super init];
    
    if (self) {
        self.reason = NSLocalizedString(@"The text field can't not be empty.", @"Validator reason (Alert)");
        self.length = kKLValidatorDefaultMinLength;
    }
    
    return self;
}

- (BOOL) validateInput:(NSString *)input error:(NSError **) error {
    NSString *text = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([text length] < self.length) {
        if (error != nil) {
            *error = [[self class] errorWithReason:self.reason code:InputValidationRequiredErrorCode];
        }
        return NO;
    }
    return YES;
}

@end
