//
//  VehicleInfoViewController.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-01.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"

@interface VehicleInfoViewController : UIViewController

@property (nonatomic, strong) Vehicle *vehicle;
@property (weak, nonatomic) IBOutlet UITextField *startOdometerTextField;
@property (weak, nonatomic) IBOutlet UITextField *endOdometerTextField;
@property (weak, nonatomic) IBOutlet UILabel *totalDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalCostLabel;

@end
