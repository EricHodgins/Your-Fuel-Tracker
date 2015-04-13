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
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SummaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.scrollView setScrollEnabled:YES];
    float scrollWidth = self.view.bounds.size.width;
    [self.scrollView setContentSize:CGSizeMake(scrollWidth, 900)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pieGraphView.frame = CGRectMake(0, 200, self.view.frame.size.width, 200);

    
    self.helperCalcCosts = [[HelperCalculations alloc] init];
    self.pieGraphView.vehicle = self.vehicle;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationController.navigationBarHidden = NO;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    
    self.gasTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalGasCost:self.vehicle.costs]];
    self.oilTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalOilCost:self.vehicle.costs]];
    self.otherTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalOtherCost:self.vehicle.costs]];
    self.grandTotalCost.text = [NSString stringWithFormat:@"%.2f", [self.helperCalcCosts calculateTotalCost:self.vehicle.costs]];
    
    [self.pieGraphView setNeedsDisplay];
    
  }






@end
