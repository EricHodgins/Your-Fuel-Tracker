//
//  HelperCalculations.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-04.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "HelperCalculations.h"

@implementation HelperCalculations

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

-(float)calculateCostPerDistance:(NSSet *)costs startDistance:(NSInteger)startDistance endDistance:(NSInteger)endDistance {
    float costPerDistance = [self calculateTotalCost:costs] / (endDistance - startDistance);
    if (isnan(costPerDistance) || costPerDistance == INFINITY) {
        return 0;
    }
    return costPerDistance;
}

-(float)calculateGasPercentage:(NSSet *)costs {
    float gasPercent = [self calculateTotalGasCost:costs] / [self calculateTotalCost:costs];
    if (isnan(gasPercent)) {
        return 0;
    }
    return gasPercent * 100;
}

-(float)calculateOilPercentage:(NSSet *)costs {
    float oilPercent = [self calculateTotalOilCost:costs] / [self calculateTotalCost:costs];
    if (isnan(oilPercent)) {
        return 0;
    }
    return oilPercent * 100;
}

-(float)calculateOtherPercentage:(NSSet *)costs {
    float otherPercent = [self calculateTotalOtherCost:costs] / [self calculateTotalCost:costs];
    if (isnan(otherPercent)) {
        return 0;
    }
    
    return otherPercent * 100;
}

@end
