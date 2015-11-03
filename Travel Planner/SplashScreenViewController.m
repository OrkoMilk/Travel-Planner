//
//  SplashScreenViewController.m
//  Travel Planner
//
//  Created by Орест on 31.10.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "HomeViewController.h"
#import <Parse/Parse.h>

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginAction:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if ([username length] < 3) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid"
                                                              message:@"Username must be greater than 3 characters"
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
    else{
//        [self.activityIndicatorView startAnimating];
        
        //login
        [PFUser logInWithUsernameInBackground:username password:password                                        block:^(PFUser *user, NSError *error) {
                                            [self.activityIndicatorView stopAnimating];
                                            
                                            if (user) {
                
                                                    HomeViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idHome"];
                                                    [self presentViewController:newController animated:YES completion:nil];
                                                

                                            } else {
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                message:nil
                                                                                               delegate:self
                                                                                      cancelButtonTitle:@"OK"
                                                                                      otherButtonTitles: nil];
                                                [alert show];
                                            }
                                        }];
        
        
    }
    
//    [self.activityIndicatorView stopAnimating]; // ????
}




@end
