//
//  AddEntryViewController.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-01.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "AddEntryViewController.h"
#import "CoreDataStack.h"

@interface AddEntryViewController ()

@end

@implementation AddEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    Costs *costs = [NSEntityDescription insertNewObjectForEntityForName:@"Costs" inManagedObjectContext:coreDataStack.managedObjectContext];
    costs.gasCost = self.gasCostTextField.text.floatValue;
    costs.odometerReading = self.odometerTextField.text.floatValue;
    costs.date = [[_datePicker date] timeIntervalSince1970];
    
    [self.vehicle addCostsObject:costs];
    [coreDataStack saveContext];
    
}


@end
