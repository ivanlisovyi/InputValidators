//
//  ExampleViewController.m
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 06.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import "ExampleViewController.h"
#import "ValidatorExampleViewController.h"

#import "InputValidator.h"
#import "UITextField+InputValidator.h"

@interface ExampleViewController ()

@property (nonatomic, strong) NSArray *titles;

@end

@implementation ExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Validation Example", @"");
    self.titles = @[@"RequiredInputValidator", @"EmailInputValidator", @"AlphaInputValidator", @"NumericInputValidator"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_titles count];
}

- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Manual Validation", @"");
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ValidatorExampleViewController *viewController = [[ValidatorExampleViewController alloc] init];
    viewController.validatorType = indexPath.row;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
