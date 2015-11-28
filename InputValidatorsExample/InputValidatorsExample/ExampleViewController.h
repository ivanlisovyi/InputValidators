//
//  ExampleViewController.h
//  InputValidatorsExample
//
//  Created by Ivan Lisovyi on 06.11.13.
//  Copyright (c) 2015 Ivan Lisovyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExampleViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end
