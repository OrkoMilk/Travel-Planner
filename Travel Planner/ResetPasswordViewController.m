//
//  ResetPasswordViewController.m
//  Travel Planner
//
//  Created by Орест on 31.10.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import <Parse/Parse.h>

@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)resetPassAction:(id)sender {
    NSString *email = self.resetPassTextField.text;
    NSString *finalEmail = [email stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceCharacterSet];
    [PFUser requestPasswordResetForEmailInBackground:finalEmail];
    
}


@end
