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
    
    if (!self.isAddEntry) {
        self.gasCostTextField.text = [NSString stringWithFormat:@"%.2f", self.costs.gasCost];
        self.oilCostTextField.text = [NSString stringWithFormat:@"%.2f", self.costs.oilCost];
        self.odometerTextField.text = [NSString stringWithFormat:@"%d", self.costs.odometerReading];
        self.otherCostTextField.text = [NSString stringWithFormat:@"%.2f", self.costs.otherCost];
        self.describeOtherCostTextField.text = self.costs.otherExplained;
        self.datePicker.date = [NSDate dateWithTimeIntervalSince1970:self.costs.date];
    }

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

}

-(void) updateEntry {
    if ([self checkOdometerIsEntered]) {
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        self.costs.gasCost = self.gasCostTextField.text.floatValue;
        self.costs.oilCost = self.oilCostTextField.text.floatValue;
        self.costs.otherCost = self.otherCostTextField.text.floatValue;
        self.costs.otherExplained = self.describeOtherCostTextField.text;
        self.costs.odometerReading = self.odometerTextField.text.integerValue;
        self.costs.date = [[_datePicker date] timeIntervalSince1970];
        [coreDataStack saveContext];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bad Odometer Reading" message:@"Must be 0 or greater." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    

}

- (void) addEntry {
    if ([self checkOdometerIsEntered]) {
        CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
        Costs *costs = [NSEntityDescription insertNewObjectForEntityForName:@"Costs" inManagedObjectContext:coreDataStack.managedObjectContext];
        costs.gasCost = self.gasCostTextField.text.floatValue;
        costs.oilCost = self.oilCostTextField.text.floatValue;
        costs.odometerReading = self.odometerTextField.text.integerValue;
        costs.otherCost = self.otherCostTextField.text.floatValue;
        costs.otherExplained = self.describeOtherCostTextField.text;
        costs.date = [[_datePicker date] timeIntervalSince1970];
        
        [self.vehicle addCostsObject:costs];
        [coreDataStack saveContext];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bad Odometer Reading" message:@"Must be 0 or greater." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

-(BOOL)checkOdometerIsEntered {
    if (self.odometerTextField.text.integerValue > 0) {
        return TRUE;
    }else {
        return FALSE;
    }
}

@end
