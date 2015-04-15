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
    
    [self addConstraints];
    
    [self.scrollView setScrollEnabled:YES];
    float scrollWidth = self.view.bounds.size.width;
    [self.scrollView setContentSize:CGSizeMake(scrollWidth, 700)];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pieGraphView.frame = CGRectMake(0, 250, self.view.frame.size.width, 200);

    
    self.helperCalcCosts = [[HelperCalculations alloc] init];
    self.pieGraphView.vehicle = self.vehicle;
    
}


-(void) addConstraints {
    
    CGFloat labelWidth = self.view.bounds.size.width - self.gasTextLabel.frame.size.width - 16.0f;
    CGRect gasFrame = CGRectMake(self.gasTotalCost.frame.origin.x, self.gasTotalCost.frame.origin.y, labelWidth, self.gasTotalCost.frame.size.height);
    self.gasTotalCost.frame = gasFrame;
    
    CGRect oilFrame = CGRectMake(self.oilTotalCost.frame.origin.x, self.oilTotalCost.frame.origin.y, labelWidth, self.oilTotalCost.frame.size.height);
    self.oilTotalCost.frame = oilFrame;
    
    CGRect otherFrame = CGRectMake(self.otherTotalCost.frame.origin.x, self.otherTotalCost.frame.origin.y, labelWidth, self.otherTotalCost.frame.size.height);
    self.otherTotalCost.frame = otherFrame;
    
    CGRect totalFrame = CGRectMake(self.grandTotalCost.frame.origin.x, self.grandTotalCost.frame.origin.y, labelWidth, self.grandTotalCost.frame.size.height);
    self.grandTotalCost.frame = totalFrame;
    
    CGFloat separatorWidth = self.view.bounds.size.width - 120;
    CGRect separatorFrame = CGRectMake(self.separotorView.frame.origin.x, self.separotorView.frame.origin.y, separatorWidth, self.separotorView.frame.size.height);
    self.separotorView.frame = separatorFrame;
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
