//
//  Costs.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-31.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "Costs.h"


@implementation Costs

@dynamic date;
@dynamic gasCost;
@dynamic odometerReading;
@dynamic oilCost;
@dynamic otherCost;
@dynamic otherExplained;
@dynamic vehicle;

@synthesize sectionName;

-(NSString *)sectionName {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM YYY"];
    
    return [dateFormatter stringFromDate:date];

}

@end
