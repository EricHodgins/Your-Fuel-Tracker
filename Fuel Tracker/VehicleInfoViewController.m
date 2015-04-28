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

#import "HelperCalculations.h"

@interface VehicleInfoViewController () <NSFetchedResultsControllerDelegate, UITextFieldDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UIBarButtonItem *buttonItem;
@property (nonatomic, strong) HelperCalculations *calculateCosts;
@property (weak, nonatomic) IBOutlet UILabel *costPerDistanceLabel;

@property (strong, nonatomic) IBOutlet UIButton *ownerPic;
@property (strong, nonatomic) UIImage *pickedImage;
@property (strong, nonatomic) IBOutlet UITextField *ownerName;


@end

@implementation VehicleInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.title = self.vehicle.owner;
    self.calculateCosts = [[HelperCalculations alloc] init];
    self.ownerPic.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (self.vehicle.imageData) {
        UIImage *pic = [UIImage imageWithData:self.vehicle.imageData];
        [self.ownerPic setImage:pic forState:UIControlStateNormal];
        [self.ownerPic setImage:pic forState:UIControlStateHighlighted];
    } else {
        UIImage *pic = [UIImage imageNamed:@"Pic Placeholder.png"];
        [self.ownerPic setImage:pic forState:UIControlStateNormal];
    }
    
    [self addConstraints];
    
    self.startOdometerTextField.delegate = self;
    self.ownerName.delegate = self;
    
    self.startOdometerTextField.enabled = NO;
    self.buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(makeEditable)];
}

-(void)addConstraints {
    CGFloat sepatorWidth = self.view.bounds.size.width - 120;
    CGRect separatorFrame = CGRectMake(self.separator.frame.origin.x, self.separator.frame.origin.y, sepatorWidth , self.separator.frame.size.height);
    self.separator.frame = separatorFrame;
    
    CGFloat labelWidth = (self.view.bounds.size.width / 2) - 8.0f;
    
    CGRect startTextFrame = CGRectMake(self.startLabel.frame.origin.x, self.startLabel.frame.origin.y, labelWidth, self.startLabel.frame.size.height);
    self.startLabel.frame = startTextFrame;
    
    CGRect endTextFrame = CGRectMake(self.startLabel.frame.origin.x + labelWidth, self.endLabel.frame.origin.y, labelWidth, self.endLabel.frame.size.height);
    self.endLabel.frame = endTextFrame;
    
    CGRect startFieldFrame = CGRectMake(self.startOdometerTextField.frame.origin.x, self.startOdometerTextField.frame.origin.y, labelWidth, self.startOdometerTextField.frame.size.height);
    self.startOdometerTextField.frame = startFieldFrame;
    
    
    //end od. label
    CGRect endOdometerLabel = CGRectMake(self.startLabel.frame.origin.x + labelWidth, self.endingOdometerLabel.frame.origin.y, labelWidth, self.endingOdometerLabel.frame.size.height);
    self.endingOdometerLabel.frame = endOdometerLabel;
    

    CGFloat distanceWidth = self.view.bounds.size.width - 16.0;
    
    CGRect totalDistanceLabelFrame = CGRectMake(self.totalDistanceLabel.frame.origin.x, self.totalDistanceLabel.frame.origin.y, distanceWidth, self.totalDistanceLabel.frame.size.height);
    self.totalDistanceLabel.frame = totalDistanceLabelFrame;
    
    
    CGRect totalCostLabelFrame = CGRectMake(self.totalCostLabel.frame.origin.x, self.totalCostLabel.frame.origin.y, distanceWidth, self.totalCostLabel.frame.size.height);
    self.totalCostLabel.frame = totalCostLabelFrame;
    
    
    CGFloat costDistanceConnector = self.view.bounds.size.width / 2.0 - 8.0;
    CGRect costDistanceFrame = CGRectMake(self.costDistanceText.frame.origin.x, self.costDistanceText.frame.origin.y, costDistanceConnector, self.costDistanceText.frame.size.height);
    self.costDistanceText.frame = costDistanceFrame;
    
    CGRect costDistanceLabelFrame = CGRectMake(self.costDistanceText.frame.origin.x + costDistanceConnector, self.costPerDistanceLabel.frame.origin.y, costDistanceConnector, self.costPerDistanceLabel.frame.size.height);
    self.costPerDistanceLabel.frame = costDistanceLabelFrame;
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.ownerName.hidden = YES;
    [self upDateValues];
    
    self.tabBarController.navigationItem.rightBarButtonItem = self.buttonItem;
    [self.tabBarController.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) upDateValues {
    self.fetchedResultsController = nil;
    [self.fetchedResultsController performFetch:nil];
    self.ownerName.text = self.vehicle.owner;
    self.tabBarController.title = self.vehicle.owner;
    self.startOdometerTextField.text = [NSString stringWithFormat:@"%d", self.vehicle.startDistance];
    
    Costs *costsEndingObject = [[self.fetchedResultsController fetchedObjects] lastObject];
    // ending odo. text
    self.endingOdometerLabel.text = [NSString stringWithFormat:@"%d", costsEndingObject.odometerReading];
    
    self.totalDistanceLabel.text = [NSString stringWithFormat:@"Total Distance: %d", costsEndingObject.odometerReading - (int)self.startOdometerTextField.text.integerValue];
    
    self.totalCostLabel.text = [NSString stringWithFormat:@"Total Cost: %.2f", [self.calculateCosts calculateTotalCost:self.vehicle.costs]];
    self.costPerDistanceLabel.text = [NSString stringWithFormat:@"%.2f", [self.calculateCosts calculateCostPerDistance:self.vehicle.costs startDistance:self.startOdometerTextField.text.integerValue endDistance:self.endingOdometerLabel.text.integerValue] ];

}

-(void)makeEditable {
    self.tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneWasPressed)];
    self.ownerName.hidden = NO;
    self.ownerName.text = [NSString stringWithFormat:@"%@", self.vehicle.owner];
    self.startOdometerTextField.enabled = YES;
    [self.startOdometerTextField becomeFirstResponder];
    
}

-(void)doneWasPressed {
    [self.view endEditing:YES];
    self.ownerName.hidden = YES;
    if (self.endingOdometerLabel.text.integerValue < self.startOdometerTextField.text.integerValue) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Starting Odometer is greater than Ending Odometer reading." message:@"Do you want to save?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
        [alert show];
    } else {
        [self finishDoneMethod];
    }
    
}

-(void)finishDoneMethod {
    self.tabBarController.navigationItem.rightBarButtonItem = self.buttonItem;
    [self updateVehicleEntry];
    [self upDateValues];
    self.startOdometerTextField.enabled = NO;
    self.ownerName.hidden = YES;

}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self finishDoneMethod];
    } else {
        self.tabBarController.navigationItem.rightBarButtonItem = self.buttonItem;
        self.startOdometerTextField.enabled = NO;
        self.ownerName.hidden = YES;
        [self upDateValues];
    }
    
}




-(void)updateVehicleEntry {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    self.vehicle.startDistance = self.startOdometerTextField.text.integerValue;
    self.vehicle.owner = self.ownerName.text;
    if (self.pickedImage != nil) {
        self.vehicle.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.5);
    }
    
    [coreDataStack saveContext];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self doneWasPressed];
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - Setting/Changing Picture methods

- (IBAction)imageButtonPressed:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self promptForSource];
    } else {
        [self promptForPhotoRoll];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex != actionSheet.firstOtherButtonIndex) {
            [self promptForPhotoRoll];
        } else {
            [self promptForCamera];
        }
    }
}

-(void)promptForSource {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Roll", nil];
    
    [actionSheet showInView:self.view];
}

-(void)promptForPhotoRoll {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    controller.allowsEditing = YES;
    [self presentViewController:controller animated:YES completion:nil];
}

-(void)promptForCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    controller.allowsEditing = YES;
    [self presentViewController:controller animated:YES completion:nil];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.pickedImage = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self updateVehicleEntry];
    
}

-(void)setPickedImage:(UIImage *)pickedImage {
    _pickedImage = pickedImage;
    
    if (pickedImage != nil) {
        [self.ownerPic setImage:pickedImage forState:UIControlStateNormal];
        [self.ownerPic setImage:pickedImage forState:UIControlStateHighlighted];
    }

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
