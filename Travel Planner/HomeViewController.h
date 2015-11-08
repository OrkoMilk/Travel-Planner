//
//  HomeViewController.h
//  Travel Planner
//
//  Created by Орест on 31.10.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//push
@property (strong, nonatomic) NSString * userID;

//actions
- (IBAction)logOutAction:(id)sender;
- (IBAction)addNewEvent:(id)sender;

@end
