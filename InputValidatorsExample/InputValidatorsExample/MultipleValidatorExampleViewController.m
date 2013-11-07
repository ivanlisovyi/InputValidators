//
//  MultipleValidatorExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 07.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "MultipleValidatorExampleViewController.h"
#import "InputValidator.h"

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
    BOOL isValid = [InputValidator validateInput:_textField.text validators:validators error:&error];
    
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
            return @[[InputValidator requiredValidator], [InputValidator emailValidator]];
            
        case ValidatorTypeRequiredAndAlpha:
            return @[[InputValidator requiredValidator], [InputValidator alphaValidator]];
            
        case ValidatorTypeRequiredAndNumeric:
            return @[[InputValidator requiredValidator], [InputValidator numericValidator]];
        
        default:
            break;
    }
    
    return nil;
}

@end
