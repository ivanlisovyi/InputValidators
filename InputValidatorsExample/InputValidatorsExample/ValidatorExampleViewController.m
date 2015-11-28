//
//  ValidatorExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 07.11.13.
//  Copyright (c) 2015 Ivan Lisovyi. All rights reserved.
//

#import "ValidatorExampleViewController.h"
#import "LKValidators.h"

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

#pragma mark - IBActions

- (IBAction)validateBtnHandler:(id)sender {
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
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark -

- (LKValidator *)inputValidator {
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
