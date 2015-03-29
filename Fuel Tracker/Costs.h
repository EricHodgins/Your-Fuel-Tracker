//
//  Costs.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-29.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Costs : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * gasCost;
@property (nonatomic, retain) NSNumber * odometerReading;
@property (nonatomic, retain) NSNumber * oilCost;
@property (nonatomic, retain) NSNumber * otherCost;
@property (nonatomic, retain) NSString * otherExplained;
@property (nonatomic, retain) NSManagedObject *vehicle;

@end
