//
//  ExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 06.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "ExampleViewController.h"

#import "InputValidator.h"
#import "UITextField+InputValidator.h"

@interface ExampleViewController ()

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Validation Example", @"");
    
    InputValidator *requiredValidator = [InputValidator requiredValidator];
    [_textField addValidator:requiredValidator];
    
    InputValidator *emailValidator = [InputValidator emailValidator];
    [_textField addValidator:emailValidator];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark IBActions 

- (IBAction) validationBtnHandler:(id)sender {
    BOOL isValid = [_textField validate];
    if (!isValid) {
        NSLog(@"%@", [_textField errorMessage]);
    }
    else {
        NSLog(@"valid");
    }
}

@end
