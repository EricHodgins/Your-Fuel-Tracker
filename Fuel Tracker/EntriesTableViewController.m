//
//  EntriesTableViewController.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-01.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "EntriesTableViewController.h"
#import "AddEntryViewController.h"

#import "CoreDataStack.h"
#import "Costs.h"

@interface EntriesTableViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) UIBarButtonItem *addButtonItem;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation EntriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSSet *costs = self.vehicle.costs;
    for (Costs *cost in costs) {
        NSLog(@"%f",cost.gasCost);
    }
    
    self.addButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(moveToEntryViewController)];
    [self.fetchedResultsController performFetch:nil];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.navigationController.navigationBarHidden = NO;
    self.tabBarController.navigationItem.rightBarButtonItem = self.addButtonItem;
    
    [self.tableView reloadData];
}

- (void)moveToEntryViewController {
    [self performSegueWithIdentifier:@"addEntry" sender:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSLog(@"Number of sections: %d", self.fetchedResultsController.sections.count);
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSLog(@"Number of rows in section: %d", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Costs *costs = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSLog(@"gas cost: %f", costs.gasCost);
    cell.textLabel.text = [NSString stringWithFormat:@"Gas:%f   Odometer:%i", costs.gasCost, costs.odometerReading];
    return cell;
}




#pragma mark - Configure the fetched results controller

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
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    return fetchRequest;
    
}

#pragma mark - Configure Add Delete Edit tableview when coredata is updated
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

#pragma mark - Editing the rows
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    Costs *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    [[coreDataStack managedObjectContext] deleteObject:entry];
    [coreDataStack saveContext];
}










#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addEntry"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddEntryViewController *addEntryController = (AddEntryViewController *) navigationController.topViewController;
        addEntryController.vehicle = self.vehicle;
    }
}


@end
