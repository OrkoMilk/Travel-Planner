//
//  CreateEventViewController.m
//  Travel Planner
//
//  Created by Орест on 01.11.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import "CreateEventViewController.h"
#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface CreateEventViewController ()

@property (strong, nonatomic)NSDate *fromDate;
@property (strong, nonatomic)NSDate *toDate;
@property (strong, nonatomic)NSDate *currentDate;
@property (assign, nonatomic) int days;

@end

@implementation CreateEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //push
    self.eventNameTextField.text = self.stringForEventName;
    self.destinationTextField.text = self.stringForDestination;
    self.commentsTextView.text = self.stringForComments;
    
    //date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, ''yy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    NSString *fromDateString = [dateFormatter stringFromDate:self.datePiker.date];
    NSString *toDateString = [dateFormatter stringFromDate:self.datePiker.date];
    
    self.fromLabel.text = fromDateString;
    self.toLabel.text = toDateString;
    
    self.fromDate = self.datePiker.date;
    self.toDate = self.datePiker.date;
    
    
    //date currentDate
    self.currentDate = [NSDate date];
    //min date
    self.datePiker.minimumDate = self.currentDate;
    
}

- (IBAction)didChangeDate:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, ''yy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    
    
    NSString *formattedDate = [dateFormatter stringFromDate:self.datePiker.date];
    
    
        switch (self.fromToSegment.selectedSegmentIndex) {
            case 0:
                self.fromLabel.text = formattedDate;
                self.fromDate = self.datePiker.date;
                [self coutDay];
                break;
            case 1:
                self.toLabel.text = formattedDate;
                self.toDate = self.datePiker.date;
                [self coutDay];
                break;
            default:
                break;
        }
    
    if (self.days < 0) {
        
        NSString *formatt = [dateFormatter stringFromDate:self.currentDate];
        self.fromLabel.text = formatt;
        UIAlertController *all = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"incorrect start date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [all addAction:ok];
        [self presentViewController:all animated:YES completion:nil];
        
    }

}


- (void) coutDay {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    int unitFlag = NSCalendarUnitDay;

    NSDateComponents *components = [calendar components:unitFlag fromDate:self.fromDate toDate:self.toDate options:0];
    
    self.days = [components day];
    
    NSLog(@"%i",self.days);
}

- (IBAction)saveEventAction:(id)sender {
    
    PFUser *user = [PFUser currentUser];
    
    NSString *eventName = self.eventNameTextField.text;
    NSString *destination = self.destinationTextField.text;
    NSString *comments = self.commentsTextView.text;
    NSString *userID = [user objectId];
    NSDate *date = self.toDate;
    
    
    PFObject *event = [PFObject objectWithClassName:@"Event"];
    event[@"eventName"] = eventName;
    event[@"destination"] = destination;
    event[@"comments"] = comments;
    event[@"usetID"] = userID;
    event[@"date"] = date;
    
    if (![self.replace isEqualToString:@"1"]) {
    
        [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (succeeded) {
                HomeViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idHome"];
                [self presentViewController:newController animated:YES completion:nil];
            }
            
        }];
    }else{
    
        PFQuery *query = [PFQuery queryWithClassName:@"Event"];
        
        [query getObjectInBackgroundWithId:self.tempObject block:^(PFObject *event, NSError *error) {
            
            NSString *eventName = self.eventNameTextField.text;
            NSString *destination = self.destinationTextField.text;
            NSString *comments = self.commentsTextView.text;
            
            event[@"eventName"] = eventName;
            event[@"destination"] = destination;
            event[@"comments"] = comments;

            [event saveInBackground];
            
            HomeViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idHome"];
            
            newController.userID = userID;
            
            [self presentViewController:newController animated:YES completion:nil];
            
        }];

    }
    
}

@end
