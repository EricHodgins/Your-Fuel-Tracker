//
//  Vehicle.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-03-31.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Costs;

@interface Vehicle : NSManagedObject

@property (nonatomic) NSTimeInterval dateAdded;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic) int16_t startDistance;
@property (nonatomic, retain) NSSet *costs;
@end

@interface Vehicle (CoreDataGeneratedAccessors)

- (void)addCostsObject:(Costs *)value;
- (void)removeCostsObject:(Costs *)value;
- (void)addCosts:(NSSet *)values;
- (void)removeCosts:(NSSet *)values;

@end
