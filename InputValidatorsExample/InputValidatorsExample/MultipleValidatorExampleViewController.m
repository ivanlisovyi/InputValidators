//
//  MultipleValidatorExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 07.11.13.
//  Copyright (c) 2015 Ivan Lisovyi. All rights reserved.
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

#pragma mark - IBActions

- (IBAction)validateBtnHandler:(id)sender {
    NSError *error = nil;
    LKMultipleValidator *validator = [LKMultipleValidator validator];
    validator.validators = [self inputValidators];
    BOOL isValid = [validator validate:self.textField.text error:&error];
    
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

- (NSArray *)inputValidators {
    switch (_validatorsType) {
        case ValidatorTypeRequiredAndEmail:
            return @[[LKRequiredValidator validator], [LKEmailValidator validator]];
            
        case ValidatorTypeRequiredAndAlpha:
            return @[[LKRequiredValidator validator], [LKAlphaValidator validator]];
            
        case ValidatorTypeRequiredAndNumeric:
            return @[[LKRequiredValidator validator], [LKNumericValidator validator]];
        
        default:
            break;
    }
    
    return nil;
}

@end
