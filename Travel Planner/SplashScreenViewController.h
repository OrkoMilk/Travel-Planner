//
//  SplashScreenViewController.h
//  Travel Planner
//
//  Created by Орест on 31.10.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SplashScreenViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;

- (IBAction)loginAction:(id)sender;


@end
