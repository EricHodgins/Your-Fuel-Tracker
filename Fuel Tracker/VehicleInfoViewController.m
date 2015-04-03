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

@interface VehicleInfoViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UIBarButtonItem *buttonItem;

@end

@implementation VehicleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    Costs *costsEndingObject = [[self.fetchedResultsController fetchedObjects] lastObject];
    self.endOdometerTextField.text = [NSString stringWithFormat:@"%d", costsEndingObject.odometerReading];
    
    self.totalDistanceLabel.text = [NSString stringWithFormat:@"%d", costsEndingObject.odometerReading - self.startOdometerTextField.text.integerValue];

}

-(void)makeEditable {
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWasPressed)];
}

-(void)doneWasPressed {
    self.tabBarController.navigationItem.rightBarButtonItem = self.buttonItem;
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
    NSLog(@"%@", self.vehicle.owner);
    //Fetch Only Gas Entries
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"vehicle = %@", self.vehicle];
    [fetchRequest setPredicate:predicate];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"odometerReading" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    return fetchRequest;
    
}



@end
