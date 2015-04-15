//
//  GraphicView.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-05.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "GraphicView.h"

@interface GraphicView()

@property CGPoint pieCenter;
@property CGFloat radius;

@property CGPoint gasEndPoint;
@property CGPoint oilEndPoint;

@property float gasCost;
@property float oilCost;
@property float otherCost;

@property float gasAngleEnd;
@property float oilAngleEnd;
@property float otherAngleEnd;
@property float separator;


@end


@implementation GraphicView

-(void)positionGasLabel:(float)endAngle radius:(float)radius centerPt:(CGPoint)centerPt startPt:(CGPoint)startPt {
    CGPoint endPoint;
    endAngle = endAngle / 2;
    endPoint.x = centerPt.x + 60*(cos(endAngle));
    endPoint.y = centerPt.y + 60*(sin(endAngle));
    
    float x_offset = 0;
    float y_offset = 0;
    
    if (endAngle >= (M_PI)) {
        x_offset = -50;
    }
    
    if (endAngle <= (M_PI / 8)) {
        x_offset = 10.0;
        y_offset = -35;
    }
    
    CGRect frame;
    frame.origin.x = endPoint.x + x_offset;
    frame.origin.y = endPoint.y + y_offset;
    frame.size.height = 35;
    frame.size.width = 50;
    
    self.gasPercentage.frame = frame;
    self.gasPercentage.text = [NSString stringWithFormat:@"Gas\n%.2f%%", [self.helper calculateGasPercentage:self.vehicle.costs]];


}

-(void)positionOilLabel:(float)startAngle endAngle:(float)endAngle radius:(float)radius centerPt:(CGPoint)centerPt {
    endAngle = endAngle - ((endAngle - startAngle) / 2);
    CGPoint endPoint;
    endPoint.x = centerPt.x + 60*(cos(endAngle));
    endPoint.y = centerPt.y + 60*(sin(endAngle));
    
    // Making offsets to take into account the frame.  Origin must be in top left corner.
    float x_offset = -50;
    float y_offset = -15;
    
    if (endAngle <= (M_PI / 2)) {
        x_offset = 0;
        y_offset = 0;
    }
    
    if (endAngle >= (M_PI)) {
        x_offset = -50;
        y_offset = -35;
    }
    
    CGRect frame;
    frame.origin.x = endPoint.x + x_offset;
    frame.origin.y = endPoint.y + y_offset;
    frame.size.height = 35;
    frame.size.width = 50;
    
    self.oilPercentage.frame = frame;
    self.oilPercentage.text = [NSString stringWithFormat:@"Oil\n%.2f%%", [self.helper calculateOilPercentage:self.vehicle.costs]];
}

-(void)positionOtherLabel:(float)startAngle endAngle:(float)endAngle radius:(float)radius centerPt:(CGPoint)centerPt {
    endAngle = endAngle - ((endAngle - startAngle) / 2);
    CGPoint endPoint;
    endPoint.x = centerPt.x + 60*(cos(endAngle));
    endPoint.y = centerPt.y + 60*(sin(endAngle));
    
    float x_offset = 0;
    float y_offset = -35;
    
    if (endAngle >= (M_PI) && endAngle <= (M_PI + (M_PI / 2))) {
        x_offset = -50;
    }
    
    CGRect frame;
    frame.origin.x = endPoint.x + x_offset;
    frame.origin.y = endPoint.y + y_offset;
    frame.size.height = 35;
    frame.size.width = 50;
    
    self.otherPercentage.frame = frame;
    self.otherPercentage.text = [NSString stringWithFormat:@"Other\n%.2f%%", [self.helper calculateOtherPercentage:self.vehicle.costs]];
}

-(void)drawRect:(CGRect)rect {
    self.helper = [[HelperCalculations alloc] init];
    float gas = [self.helper calculateGasPercentage:self.vehicle.costs] / 100;
    float oil = [self.helper calculateOilPercentage:self.vehicle.costs] / 100;
    float other = [self.helper calculateOtherPercentage:self.vehicle.costs] / 100;
    
    // For a slight white line that separates each portion (gas, oil, other).
    float separator = (M_PI * 2) / 180;
    
    if ((gas >= 1) || (oil >= 1) || (other >= 1)) {
        separator = 0;
    }
    
    
    CGPoint pieCenter = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    CGFloat radius = pieCenter.y - 40.f;
    
    
    if (gas != 0) {
        UIBezierPath *portionPath = [UIBezierPath bezierPath];
        [portionPath moveToPoint:pieCenter];
        [portionPath addArcWithCenter:pieCenter radius:radius startAngle:0.f endAngle:(M_PI * 2)*gas - separator clockwise:YES];
        [portionPath closePath];
        
        if (gas >= 0.056) {
            UIColor *red = [UIColor colorWithRed:190.0f/255.0f green:19.0f/255.0f blue:19.0f/255.0f alpha:0.77f];
            [red setFill];
            [portionPath fill];
        }
        
        [self positionGasLabel:(M_PI * 2)*gas radius:radius centerPt:pieCenter startPt:CGPointMake(pieCenter.x + radius, pieCenter.y)];
    } else {
        self.gasPercentage.text = @"";
    }
    

    if (oil != 0) {
        UIBezierPath *portionPath1 = [UIBezierPath bezierPath];
        [portionPath1 moveToPoint:pieCenter];
        [portionPath1 addArcWithCenter:pieCenter radius:radius startAngle:(M_PI * 2) * gas endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas) - separator clockwise:YES];
        [portionPath1 closePath];
        
        [[UIColor blueColor] setFill];
        [portionPath1 fill];
        
        [self positionOilLabel:(M_PI * 2)*gas endAngle:(M_PI * 2 * oil)+(M_PI * 2 * gas) - separator radius:radius centerPt:pieCenter];
    } else {
        self.oilPercentage.text = @"";
    }
    
    if (other != 0) {
        UIBezierPath *portionPath2 = [UIBezierPath bezierPath];
        [portionPath2 moveToPoint:pieCenter];
        [portionPath2 addArcWithCenter:pieCenter radius:radius startAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas) endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas)+(M_PI * 2 * other) - separator clockwise:YES];
        [portionPath2 closePath];
        
        UIColor *green = [UIColor colorWithRed:49.0f/255.0f green:165.0f/255.0f blue:80.0f/255.0f alpha:0.80f];
        [green setFill];
        [portionPath2 fill];
        
        
        [self positionOtherLabel:(M_PI * 2 *oil)+(M_PI * 2 * gas) endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas)+(M_PI * 2 * other) - separator radius:radius centerPt:pieCenter];
    } else {
        self.otherPercentage.text = @"";
    }

 
}







@end
