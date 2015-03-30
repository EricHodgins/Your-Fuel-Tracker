//
//  OwnerTableViewCell.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-29.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"

@interface OwnerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *ownerName;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

- (void) configureCellForEntry: (Vehicle *)entry;

@end
