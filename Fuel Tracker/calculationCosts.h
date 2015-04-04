//
//  calculationCosts.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-03.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculationCosts : NSObject

-(float)calculateTotalGasCost: (NSSet *)costs;
-(float)calculateTotalOilCost: (NSSet *)costs;
-(float)calculateTotalOtherCost: (NSSet *)costs;

-(float)calculateTotalCost: (NSSet *)costs;


@end
