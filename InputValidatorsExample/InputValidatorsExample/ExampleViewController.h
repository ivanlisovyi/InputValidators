//
//  ExampleViewController.h
//  InputValidatorsExample
//
//  Created by Ivan Lisovoy on 06.11.13.
//  Copyright (c) 2013 Ramotion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
