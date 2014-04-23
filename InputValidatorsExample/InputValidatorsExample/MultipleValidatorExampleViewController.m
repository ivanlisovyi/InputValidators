//
//  MultipleValidatorExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 07.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "MultipleValidatorExampleViewController.h"
#import "LKValidators.h"

@interface MultipleValidatorExampleViewController ()

@end

@implementation MultipleValidatorExampleViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Multiple Validators", @"");
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Validate", @"")
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(validateBtnHandler:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) validateBtnHandler:(id)sender {
    NSArray *validators = [self inputValidators];
    
    NSError *error = nil;
    BOOL isValid = [LKValidator validateInput:_textField.text validators:validators error:&error];
    
    NSString *message = nil;
    if (isValid) {
        message = @"Input is valid";
    }
    else {
        message = error.localizedFailureReason;
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
    [alertView show];
}

#pragma mark -

- (NSArray *) inputValidators {
    switch (_validatorsType) {
        case ValidatorTypeRequiredAndEmail:
            return @[[LKRequiredInputValidator validator], [LKEmailInputValidator validator]];
            
        case ValidatorTypeRequiredAndAlpha:
            return @[[LKRequiredInputValidator validator], [LKAlphaInputValidator validator]];
            
        case ValidatorTypeRequiredAndNumeric:
            return @[[LKRequiredInputValidator validator], [LKNumericInputValidator validator]];
        
        default:
            break;
    }
    
    return nil;
}

@end
