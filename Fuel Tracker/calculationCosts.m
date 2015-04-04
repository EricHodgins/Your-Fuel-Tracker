//
//  calculationCosts.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-03.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "CalculationCosts.h"
#import "Costs.h"

@implementation CalculationCosts

-(float)calculateTotalGasCost:(NSSet *)costs {
    NSSet *total = costs;
    float sumGas = 0;
    
    for (Costs *gasCost in total) {
        sumGas += gasCost.gasCost;
    }
    
    return sumGas;
}

-(float)calculateTotalOilCost:(NSSet *)costs {
    NSSet *total = costs;
    float oilSum = 0;
    
    for (Costs *oilCost in total) {
        oilSum += oilCost.oilCost;
    }
    
    return oilSum;
}

-(float)calculateTotalOtherCost:(NSSet *)costs {
    NSSet *total = costs;
    float otherSum = 0;
    
    for (Costs *otherCost in total) {
        otherSum += otherCost.otherCost;
    }
    
    return otherSum;
}

-(float)calculateTotalCost:(NSSet *)costs {
    return [self calculateTotalGasCost:costs] + [self calculateTotalOilCost:costs] + [self calculateTotalOtherCost:costs];
}

@end
