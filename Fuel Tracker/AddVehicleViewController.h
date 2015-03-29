//
//  ViewController.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-29.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddVehicleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *ownerName;
@property (weak, nonatomic) IBOutlet UIButton *imageButton;
@property (strong, nonatomic) UIImage *pickedImage;

@end

