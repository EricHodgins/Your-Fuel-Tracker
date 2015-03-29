//
//  Costs.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-29.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Vehicle;

@interface Costs : NSManagedObject

@property (nonatomic) NSTimeInterval date;
@property (nonatomic) float gasCost;
@property (nonatomic) int16_t odometerReading;
@property (nonatomic) float oilCost;
@property (nonatomic) float otherCost;
@property (nonatomic, retain) NSString * otherExplained;
@property (nonatomic, retain) NSSet *vehicle;
@end

@interface Costs (CoreDataGeneratedAccessors)

- (void)addVehicleObject:(Vehicle *)value;
- (void)removeVehicleObject:(Vehicle *)value;
- (void)addVehicle:(NSSet *)values;
- (void)removeVehicle:(NSSet *)values;

@end
