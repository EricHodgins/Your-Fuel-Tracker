//
//  AddVehicleViewController.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-31.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "AddVehicleViewController.h"
#import "CoreDataStack.h"
#import "Vehicle.h"


@interface AddVehicleViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (strong, nonatomic) UIImage *pickedImage;

@end

@implementation AddVehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addConstraints];
    
    self.imageButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)addConstraints {
    CGFloat width = self.view.bounds.size.width - 32.0;
    CGRect ownerTextFrame = CGRectMake(self.ownerName.frame.origin.x, self.ownerName.frame.origin.y, width, 30);
    self.ownerName.frame = ownerTextFrame;
    
    CGRect buttonImageFrame = CGRectMake(self.imageButton.frame.origin.x, self.imageButton.frame.origin.y, width, 185);
    self.imageButton.frame = buttonImageFrame;
}



- (IBAction)cancelWasPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveWasPressed:(id)sender {
    if (self.ownerName.text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You did not name a vehicle." message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    } else {
        [self insertVehicleEntry];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) insertVehicleEntry {
    CoreDataStack *coreDataStack = [CoreDataStack defaultStack];
    Vehicle *vehicle = [NSEntityDescription insertNewObjectForEntityForName:@"Vehicle" inManagedObjectContext:coreDataStack.managedObjectContext];
    
    vehicle.owner = self.ownerName.text;
    vehicle.dateAdded = [[NSDate date] timeIntervalSince1970];
    
    if (self.pickedImage != nil) {
        vehicle.imageData = UIImageJPEGRepresentation(self.pickedImage, 0.1);
    }
    
    [coreDataStack saveContext];

}


- (void)setPickedImage:(UIImage *)pickedImage {
    _pickedImage = pickedImage;
    
    if (pickedImage != nil) {
        [self.imageButton setImage:pickedImage forState:UIControlStateNormal];
    }
}


#pragma mark - setting up picking an image for the owner

- (IBAction)imageButtonPressed:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [self promptForSource];
    } else {
        [self promptForPhotoRoll];
    }
}

- (void) promptForSource {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Photo Roll", nil];
    [actionSheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != actionSheet.cancelButtonIndex) {
        if (buttonIndex != actionSheet.firstOtherButtonIndex) {
            [self promptForPhotoRoll];
        } else {
            [self promptForCamera];
        }
    }
}

- (void)promptForCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    controller.allowsEditing = YES;
    [self presentViewController:controller animated:YES completion:nil];
    
}

- (void)promptForPhotoRoll {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    controller.allowsEditing = YES;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.pickedImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}








@end
