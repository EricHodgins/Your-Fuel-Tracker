//
//  AddEntryViewController.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-01.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"
#import "Costs.h"

@interface AddEntryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *gasCostTextField;
@property (weak, nonatomic) IBOutlet UITextField *odometerTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property(nonatomic, strong) Vehicle *vehicle;
@property(nonatomic, strong) Costs *costs;

@end
