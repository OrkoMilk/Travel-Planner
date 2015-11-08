//
//  HomeViewController.m
//  Travel Planner
//
//  Created by Орест on 31.10.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import "HomeViewController.h"
#import "SplashScreenViewController.h"
#import "OMTableViewCell.h"
#import "CreateEventViewController.h"
#import <Parse/Parse.h>

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *eventsArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fromParse];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (PFUser.currentUser == nil) {
        
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            SplashScreenViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idSpashScreen"];
            [self presentViewController:newController animated:YES completion:nil];
        });
    
        [self fromParse];
    }

}
// load data
- (void) fromParse {
    
    self.eventsArray = [[NSMutableArray alloc] init];

        PFQuery *fromParseEvent = [PFQuery queryWithClassName:@"Event"];
        [fromParseEvent findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            NSLog(@"%@",objects);
            
            PFUser *user = [PFUser currentUser];
            NSString *userID = [user objectId];
            
            if (!error) {
                
                for (int i = 0; i < [objects count]; i++) {
                    
                    PFObject *tempObject = [objects objectAtIndex:i];
                     NSString *temp = [tempObject objectForKey:@"usetID"];
                    
                    if ([userID isEqualToString:temp]) {
                        [self.eventsArray addObject:[objects objectAtIndex:i]];
                    }
                }
                
            }
            
            [self.tableView reloadData];
        }];    
    
}

//UIViewController
- (IBAction)logOutAction:(id)sender {
    
    [PFUser logOut];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        SplashScreenViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idSpashScreen"];
        [self presentViewController:newController animated:YES completion:nil];
    });


}

- (IBAction)addNewEvent:(id)sender {
    
    CreateEventViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idCreateEvent"];
    [self presentViewController:newController animated:YES completion:nil];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.eventsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cell";
    
    OMTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[OMTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    PFObject *tempObject = [self.eventsArray objectAtIndex:indexPath.row];
    cell.nameEventLabel.text = [tempObject objectForKey:@"eventName"];
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    int unitFlag = NSCalendarUnitDay;
    NSDateComponents *components = [calendar components:unitFlag fromDate:now toDate:[tempObject objectForKey:@"date"] options:0];
    int days = [components day];
    NSLog(@"%i",days);
    
    cell.dateToLabel.text = [NSString stringWithFormat:@"the event left:%d days",days];
    
    return cell;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *tempObject = [self.eventsArray objectAtIndex:indexPath.row];
    [tempObject deleteInBackground];
    NSLog(@"%@",tempObject);
    [self.eventsArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CreateEventViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idCreateEvent"];
    
    PFObject *tempObject = [self.eventsArray objectAtIndex:indexPath.row];
    
    newController.stringForEventName = [tempObject objectForKey:@"eventName"];
    newController.stringForDestination = [tempObject objectForKey:@"destination"];
    newController.stringForComments = [tempObject objectForKey:@"comments"];
    newController.replace = @"1";
    newController.tempObject = [tempObject objectId];
    
    [self presentViewController:newController animated:YES completion:nil];

}



@end
