//
//  TimetableViewController.h
//  Travel Planner
//
//  Created by Орест on 09.11.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimetableViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *timeTableArray;

- (IBAction)backAction:(id)sender;

@end
