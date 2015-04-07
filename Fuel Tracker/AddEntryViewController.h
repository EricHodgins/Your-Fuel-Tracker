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
@property (weak, nonatomic) IBOutlet UITextField *oilCostTextField;
@property (weak, nonatomic) IBOutlet UITextView *describeOtherCostTextField;
@property (weak, nonatomic) IBOutlet UITextField *otherCostTextField;

@property(nonatomic, strong) Vehicle *vehicle;
@property(nonatomic, strong) Costs *costs;

@property(assign) BOOL isAddEntry;

@end
