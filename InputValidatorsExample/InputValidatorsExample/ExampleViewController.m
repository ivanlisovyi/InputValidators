//
//  ExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 06.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "ExampleViewController.h"
#import "ValidatorExampleViewController.h"
#import "MultipleValidatorExampleViewController.h"

#import "InputValidator.h"
#import "UITextField+InputValidator.h"

@interface ExampleViewController ()

@property (nonatomic, strong) NSArray *manualTitles;
@property (nonatomic, strong) NSArray *multipleManualTitles;
@property (nonatomic, strong) NSArray *sectionsTitles;

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Validation Example", @"");
    self.manualTitles = @[@"RequiredInputValidator", @"EmailInputValidator", @"AlphaInputValidator", @"NumericInputValidator"];
    self.multipleManualTitles = @[@"Email+Required", @"Alpha+Required", @"Numeric+Required"];
    self.sectionsTitles = @[@"Single Manual Validation", @"Multiple Manual Validation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [_manualTitles count];
    }
    else if (section == 1) {
        return [_multipleManualTitles count];;
    }
    
    return 0;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sectionsTitles count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sectionsTitles[section];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = _manualTitles[indexPath.row];
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = _multipleManualTitles[indexPath.row];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewController = nil;
    if (indexPath.section == 0) {
        viewController = [[ValidatorExampleViewController alloc] init];
        [(ValidatorExampleViewController *)viewController setValidatorType:indexPath.row];
    }
    else if (indexPath.section == 1) {
        viewController = [[MultipleValidatorExampleViewController alloc] init];
        [(MultipleValidatorExampleViewController *)viewController setValidatorsType:indexPath.row];
    }
    
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
