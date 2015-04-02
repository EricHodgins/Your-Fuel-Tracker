//
//  AddEntryViewController.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-01.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "AddEntryViewController.h"

@interface AddEntryViewController ()

@end

@implementation AddEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"AddEntry Owner: %@", self.vehicle.owner);
}

- (IBAction)cancelWasPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneWasPressed:(id)sender {
    if (self.costs != nil) {
        [self updateEntry];
    } else {
        [self addEntry];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) updateEntry {
    
}

- (void) addEntry {
    
}


@end
