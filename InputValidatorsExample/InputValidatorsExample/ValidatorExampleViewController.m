//
//  ValidatorExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 07.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "ValidatorExampleViewController.h"
#import "LKValidators.h"

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
    LKValidator *validator = [self inputValidator];

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

- (LKValidator *) inputValidator {
    switch (_validatorType) {
        case ValidatorTypeRequired:
            return [LKRequiredInputValidator validator];
            
        case ValidatorTypeEmail:
            return [LKEmailInputValidator validator];
            
        case ValidatorTypeAlpha:
            return [LKAlphaInputValidator validator];
            
        case ValidatorTypeNumeric:
            return [LKNumericInputValidator validator];
            
        default:
            break;
    }
    
    return nil;
}

@end
