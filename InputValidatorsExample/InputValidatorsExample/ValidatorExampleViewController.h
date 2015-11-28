//
//  ValidatorExampleViewController.h
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 07.11.13.
//  Copyright (c) 2015 Ivan Lisovyi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ValidatorType) {
    ValidatorTypeRequired = 0,
    ValidatorTypeEmail,
    ValidatorTypeAlpha,
    ValidatorTypeNumeric,
};

@interface ValidatorExampleViewController : UIViewController

@property (nonatomic, assign) ValidatorType validatorType;
@property (nonatomic, weak) IBOutlet UITextField *textField;

@end
