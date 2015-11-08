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
    
    if ([username length] < 3) {
        UIAlertController *all = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Username must be greater than 3 characters" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [all addAction:ok];
        [self presentViewController:all animated:YES completion:nil];
    }
    else if ([email length] < 6){
        UIAlertController *all = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Please enter a valid email address" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [all addAction:ok];
        [self presentViewController:all animated:YES completion:nil];
        }
    else if ([password length] < 6){
        UIAlertController *all = [UIAlertController alertControllerWithTitle:@"Invalid" message:@"Password must be greater than 6 characters" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [all addAction:ok];
        [self presentViewController:all animated:YES completion:nil];
        }
    else {

        [self.activityIndicatorView startAnimating];
        PFUser *newUser = [PFUser user];
        newUser.username = username;
        newUser.password = password;
        newUser.email = finalEmail;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [self.activityIndicatorView stopAnimating];
            if (error) {
                UIAlertController *all = [UIAlertController alertControllerWithTitle:@"Error" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [all addAction:ok];
                [self presentViewController:all animated:YES completion:nil];
                } else {
                UIAlertController *all = [UIAlertController alertControllerWithTitle:@"Success" message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
                [all addAction:ok];
                [self presentViewController:all animated:YES completion:nil];
                    
                HomeViewController *newController = [self.storyboard instantiateViewControllerWithIdentifier:@"idHome"];
                [self presentViewController:newController animated:YES completion:nil];
                
            }
        }];
        
    }
}



@end
