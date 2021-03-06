//
//  HelperCalculations.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-04.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Costs.h"

@interface HelperCalculations : NSObject

-(float)calculateTotalGasCost: (NSSet *)costs;
-(float)calculateTotalOilCost: (NSSet *)costs;
-(float)calculateTotalOtherCost: (NSSet *)costs;

-(float)calculateGasPercentage: (NSSet *)costs;
-(float)calculateOilPercentage: (NSSet *)costs;
-(float)calculateOtherPercentage: (NSSet *)costs;

-(float)calculateTotalCost: (NSSet *)costs;
-(float)calculateCostPerDistance: (NSSet *)costs startDistance:(NSInteger)startDistance endDistance:(NSInteger)endDistance;



@end
