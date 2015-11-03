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
//    self.eventsArray = [[NSMutableArray alloc] init];
    
    [self fromParse];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    PFQuery *fromParseEvent = [PFQuery queryWithClassName:@"Event"];
    [fromParseEvent findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        NSLog(@"%@",objects);
        
        if (!error) {
            self.eventsArray = [[NSMutableArray alloc] initWithArray:objects];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello :)"
                                                            message:@"Зlease add an event, by clicking on the plus in the upper left corner"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
            [alert show];
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
    
    return cell;

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PFObject *tempObject = [self.eventsArray objectAtIndex:indexPath.row];
//    [tempObject removeObjectForKey:@"objectId"];
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
