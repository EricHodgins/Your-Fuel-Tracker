//
//  GraphicView.h
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-05.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Vehicle.h"

@interface GraphicView : UIView

@property (nonatomic, strong)Vehicle *vehicle;

-(CGRect)positionGasPercentLabel;

@end
