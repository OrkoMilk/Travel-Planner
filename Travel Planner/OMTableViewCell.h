//
//  OMTableViewCell.h
//  Travel Planner
//
//  Created by Орест on 01.11.15.
//  Copyright © 2015 HOME. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameEventLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateToLabel;

@end
