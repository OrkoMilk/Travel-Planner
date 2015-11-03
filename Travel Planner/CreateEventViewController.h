//
//  CreateEventViewController.h
//  Travel Planner
//
//  Created by Орест on 01.11.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePiker;
@property (weak, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UITextView *commentsTextView;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *fromToSegment;

//push
@property (strong,nonatomic) NSString *stringForEventName;
@property (strong,nonatomic) NSString *stringForDestination;
@property (strong,nonatomic) NSString *stringForComments;
@property (strong,nonatomic) NSString *replace;
@property (strong,nonatomic) NSString *tempObject;

//action
- (IBAction)saveEventAction:(id)sender;
- (IBAction)didChangeDate:(UIDatePicker *)sender;


@end
