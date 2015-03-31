//
//  VehicleInfoViewController.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-29.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "VehicleInfoViewController.h"

@interface VehicleInfoViewController () <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;


@end

@implementation VehicleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.title = self.vehicle.owner;
    NSLog(@"%@ is the vehicle owner.", self.vehicle.owner);
    NSLog(@"Cost object: %@", self.vehicle.costs);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
