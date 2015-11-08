//
//  SignUpViewController.m
//  Travel Planner
//
//  Created by Орест on 31.10.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import "SignUpViewController.h"
#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpAction:(id)sender {
    
    NSString *email = self.emailTextField.text;
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *finalEmail = [email stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
       
//    var finalEmail = email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    
    if ([username length] < 3) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid"
                                                        message:@"Username must be greater than 3 characters"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    else if ([email length] < 6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid"
                                                        message:@"Please enter a valid email address"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    else if ([password length] < 6){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid"
                                                        message:@"Password must be greater than 6 characters"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
    }
    else {
        // run activityIndicatorView
        [self.activityIndicatorView startAnimating];
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = finalEmail;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.activityIndicatorView stopAnimating];
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
            } else {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles: nil];
                [alert show];
                
//                [PFUser enableRevocableSessionInBackground];
                
                HomeViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idHome"];
                [self presentViewController:newController animated:YES completion:nil];
                
            }
        }];
        
    }
}



@end
