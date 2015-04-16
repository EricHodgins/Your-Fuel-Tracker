//
//  OwnerTableViewCell.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-01.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "OwnerTableViewCell.h"

@implementation OwnerTableViewCell

-(void)configureCellForEntry:(Vehicle *)entry {
    if (entry.owner) {
        self.ownerName.text = entry.owner;
    }
    
    if (entry.imageData) {
        self.mainImageView.image = [UIImage imageWithData:entry.imageData];
    } else {
        self.mainImageView.image = [UIImage imageNamed:@"Pic Placeholder.png"];
    }
}


@end
