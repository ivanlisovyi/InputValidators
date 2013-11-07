//
//  ValidatorExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 07.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "ValidatorExampleViewController.h"
#import "InputValidator.h"

@interface ValidatorExampleViewController ()

@end

@implementation ValidatorExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Concrete Validator", @"");
    
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
    InputValidator *validator = [self inputValidator];

    NSError *error = nil;
    BOOL isValid = [validator validateInput:_textField.text error:&error];
    
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

- (InputValidator *) inputValidator {
    switch (_validatorType) {
        case ValidatorTypeRequired:
            return [InputValidator requiredValidator];
            
        case ValidatorTypeEmail:
            return [InputValidator emailValidator];
            
        case ValidatorTypeAlpha:
            return [InputValidator alphaValidator];
            
        case ValidatorTypeNumeric:
            return [InputValidator numericValidator];
            
        default:
            break;
    }
    
    return nil;
}

@end
