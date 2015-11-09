//
//  TimetableViewController.m
//  Travel Planner
//
//  Created by Орест on 09.11.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import "TimetableViewController.h"
#import "HomeViewController.h"
#import "TimeTableViewCell.h"
#import <Parse/Parse.h>

@interface TimetableViewController ()  <UITableViewDataSource, UITableViewDelegate>

@end

@implementation TimetableViewController

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.timeTableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"cell1";
    
    TimeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[TimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    PFObject *tempObject = [self.timeTableArray objectAtIndex:indexPath.row];
    cell.eventNameLabel.text = [NSString stringWithFormat:@"Even name: %@",[tempObject objectForKey:@"eventName"]];
    cell.destinationLabel.text = [NSString stringWithFormat:@"Destination: %@",[tempObject objectForKey:@"destination"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, ''yy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *string = [dateFormatter stringFromDate:[tempObject objectForKey:@"date"]];
    cell.dateLabel.text = string;
    
    return cell;
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return @"Next Event:";
}

- (IBAction)backAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
