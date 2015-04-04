//
//  VehicleInfoViewController.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-01.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "VehicleInfoViewController.h"
#import "CoreDataStack.h"
#import "Costs.h"

#import "CalculationCosts.h"

@interface VehicleInfoViewController () <NSFetchedResultsControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UIBarButtonItem *buttonItem;
@property (nonatomic, strong) CalculationCosts *calculateCosts;

@end

@implementation VehicleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.calculateCosts = [[CalculationCosts alloc] init];
    
    self.startOdometerTextField.enabled = NO;
    self.buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(makeEditable)];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self upDateValues];
    
    self.tabBarController.navigationItem.rightBarButtonItem = self.buttonItem;
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) upDateValues {
    self.fetchedResultsController = nil;
    [self.fetchedResultsController performFetch:nil];
    
    self.startOdometerTextField.text = [NSString stringWithFormat:@"%d", self.vehicle.startDistance];
    
    Costs *costsEndingObject = [[self.fetchedResultsController fetchedObjects] lastObject];
    self.endOdometerTextField.text = [NSString stringWithFormat:@"%d", costsEndingObject.odometerReading];
    
    self.totalDistanceLabel.text = [NSString stringWithFormat:@"%d", costsEndingObject.odometerReading - self.startOdometerTextField.text.integerValue];
    
    self.totalCostLabel.text = [NSString stringWithFormat:@"%.2f", [self.calculateCosts calculateTotalCost:self.vehicle.costs]];

}

-(void)makeEditable {
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWasPressed)];
    self.startOdometerTextField.enabled = YES;
    [self.startOdometerTextField becomeFirstResponder];
    
}

-(void)doneWasPressed {
    self.tabBarController.navigationItem.rightBarButtonItem = self.buttonItem;
    [self updateVehicleEntry];
    [self upDateValues];
    [self.startOdometerTextField resignFirstResponder];
}

-(void)updateVehicleEntry {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    
    self.vehicle.startDistance = self.startOdometerTextField.text.integerValue;
    [coreDataStack saveContext];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Fetch Results for ending Odometer Reading

- (NSFetchedResultsController *) fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
    
}

- (NSFetchRequest *) entryListFetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Costs"];

    //Fetch Only Gas Entries
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vehicle = %@", self.vehicle];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"odometerReading" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    return fetchRequest;
    
}



@end
