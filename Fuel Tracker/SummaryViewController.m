//
//  SummaryViewController.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-04.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "SummaryViewController.h"
#import "HelperCalculations.h"
#import "GraphicView.h"


@interface SummaryViewController ()

@property(nonatomic, strong) HelperCalculations *helperCalcCosts;

@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.helperCalcCosts = [[HelperCalculations alloc] init];
    self.pieGraphView.vehicle = self.vehicle;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationController.navigationBarHidden = NO;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    self.gasTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalGasCost:self.vehicle.costs]];
    self.oilTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalOilCost:self.vehicle.costs]];
    self.otherTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalOtherCost:self.vehicle.costs]];
    self.grandTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalCost:self.vehicle.costs]];
    
    self.gasPercentage.text = [NSString stringWithFormat:@"Gas\n%.2f%%", [self.helperCalcCosts calculateGasPercentage:self.vehicle.costs]];
    
    [self.gasPercentage removeFromSuperview];
    [self.gasPercentage setTranslatesAutoresizingMaskIntoConstraints:YES];
    [self.gasPercentage setFrame:[self.pieGraphView positionGasPercentLabel]];
    [self.pieGraphView addSubview:self.gasPercentage];
    
    
    self.oilPercentage.text = [NSString stringWithFormat:@"Oil\n%.2f%%", [self.helperCalcCosts calculateOilPercentage:self.vehicle.costs]];
    self.otherPercentage.text = [NSString stringWithFormat:@"Other\n%.2f%%", [self.helperCalcCosts calculateOtherPercentage:self.vehicle.costs]];
    
    [self.pieGraphView setNeedsDisplay];
}






@end
