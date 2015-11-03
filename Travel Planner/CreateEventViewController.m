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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //d
}


- (IBAction)didChangeDate:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, MMM d, ''yy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    NSDate *now = [NSDate date];
    NSLog(@"%@",now);
    NSString *formattedDate = [dateFormatter stringFromDate:self.datePiker.date];
    
    
    if (self.datePiker.date < now) {
        NSLog(@"date incorect %@",self.datePiker.date);
        NSLog(@"now %@",now);
        
    }else{
               switch (self.fromToSegment.selectedSegmentIndex) {
                   case 0:
                       self.fromLabel.text = formattedDate;
                       self.fromDate = self.datePiker.date;
                       break;
                   case 1:
                       self.toLabel.text = formattedDate;
                       self.toDate = self.datePiker.date;
                       break;
                   default:
                       break;
               }
        [self coutDay];
    }
    
}

- (void) coutDay {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    int unitFlag = NSCalendarUnitDay;

    NSDateComponents *components = [calendar components:unitFlag fromDate:self.fromDate toDate:self.toDate options:0];
    
    int days = [components day];
    
    NSLog(@"%i",days);
}

- (IBAction)saveEventAction:(id)sender {
    
    NSString *eventName = self.eventNameTextField.text;
    NSString *destination = self.destinationTextField.text;
    NSString *comments = self.commentsTextView.text;
    
//    NSString *fromData =
//    NSString *toData =
    
    PFObject *event = [PFObject objectWithClassName:@"Event"];
    event[@"eventName"] = eventName;
    event[@"destination"] = destination;
    event[@"comments"] = comments;
    
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
            [self presentViewController:newController animated:YES completion:nil];
            
        }];

    }
    
}

@end
