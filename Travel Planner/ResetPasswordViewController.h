//
//  ResetPasswordViewController.h
//  Travel Planner
//
//  Created by Орест on 31.10.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPasswordViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *resetPassTextField;

- (IBAction)resetPassAction:(id)sender;

@end
