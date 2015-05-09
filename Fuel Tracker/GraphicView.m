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


@end


@implementation GraphicView {
    float oilPercent;
    float otherPercent;
    float gasPercent;
}

-(CGPoint)calculateOffsetAngle:(float)angle centerPt:(CGPoint)centrePt {
    CGPoint endPoint;
    float labelGap = 25.0;
    endPoint.x = centrePt.x + 60*(cos(angle));
    endPoint.y = centrePt.y + 60*(sin(angle));
    
    float height = fabs((endPoint.y + self.frame.origin.y) - self.center.y);
    float width = fabs(endPoint.x - self.center.x);
    float labelAngle = atan(height / width);
    
    NSLog(@"New Calc, endX: %f, endY: %f, centreX: %f, centreY: %f, OriginX: %f, OriginY: %f", endPoint.x, endPoint.y, self.center.x, self.center.y, self.frame.origin.x, self.frame.origin.y);
    if (endPoint.x >= self.center.x) {
        endPoint.x += cos(labelAngle) * labelGap;
        NSLog(@"X is greater:");
    }
    
    if (endPoint.x < self.center.x) {
        endPoint.x -= cos(labelAngle) * labelGap;
        NSLog(@"X is smaller");
    }
    
    if ((endPoint.y + self.frame.origin.y) >= self.center.y) {
        endPoint.y += sin(labelAngle) * labelGap;
        NSLog(@"Y is greater");
    }
    
    if ((endPoint.y + self.frame.origin.y) < self.center.y) {
        endPoint.y -= sin(labelAngle) * labelGap;
        NSLog(@"Y is smaller");
    }

    return endPoint;
}

-(void)positionGasLabel:(float)endAngle radius:(float)radius centerPt:(CGPoint)centerPt startPt:(CGPoint)startPt {
    CGPoint endPoint;
    CGRect frame;
    endAngle = endAngle / 2;
    endPoint = [self calculateOffsetAngle:endAngle centerPt:centerPt];
    frame.origin.x = endPoint.x;
    frame.origin.y = endPoint.y;
    frame.size.height = 35;
    frame.size.width = 50;
    CGPoint gasCenter = CGPointMake(endPoint.x, endPoint.y);
    
    self.gasPercentage.frame = frame;
    self.gasPercentage.center = gasCenter;
    self.gasPercentage.text = [NSString stringWithFormat:@"Gas\n%.2f%%", [self.helper calculateGasPercentage:self.vehicle.costs]];
}

-(void)positionOilLabel:(float)startAngle endAngle:(float)endAngle radius:(float)radius centerPt:(CGPoint)centerPt {
    CGPoint endPoint;
    CGRect frame;
    CGPoint oilCenter;
    endAngle = endAngle - ((endAngle - startAngle) / 2);
    endPoint = [self calculateOffsetAngle:endAngle centerPt:centerPt];
    frame.origin.x = endPoint.x;
    
    if (oilPercent <= 0.1 && gasPercent <= 0.1) {
        oilCenter = CGPointMake(endPoint.x, endPoint.y + 25.0);
        frame.origin.y = endPoint.y + 25.0;
    } else if (oilPercent <= 0.1 && gasPercent >= 0.5 && otherPercent <= 0.1) {
        oilCenter = CGPointMake(endPoint.x, endPoint.y - 20.0);
        frame.origin.y = endPoint.y - 20.0;
    }
    else {
        oilCenter = CGPointMake(endPoint.x, endPoint.y);
        frame.origin.y = endPoint.y;
    }
    frame.size.height = 35;
    frame.size.width = 50;
    
    self.oilPercentage.frame = frame;
    self.oilPercentage.center = oilCenter;
    self.oilPercentage.text = [NSString stringWithFormat:@"Oil\n%.2f%%", [self.helper calculateOilPercentage:self.vehicle.costs]];
}

-(void)positionOtherLabel:(float)startAngle endAngle:(float)endAngle radius:(float)radius centerPt:(CGPoint)centerPt {
    CGPoint endPoint;
    CGRect frame;
    CGPoint otherCenter;
    endAngle = endAngle - ((endAngle - startAngle) / 2);
    endPoint = [self calculateOffsetAngle:endAngle centerPt:centerPt];
    frame.origin.x = endPoint.x;
    
    if (otherPercent <= 0.1 && gasPercent <= 0.1) {
        otherCenter = CGPointMake(endPoint.x, endPoint.y - 25.0);
        frame.origin.y = endPoint.y - 25.0;
    } else {
        otherCenter = CGPointMake(endPoint.x, endPoint.y);
        frame.origin.y = endPoint.y;
    }
    frame.size.height = 35;
    frame.size.width = 50;
    
    self.otherPercentage.frame = frame;
    self.otherPercentage.center = otherCenter;
    self.otherPercentage.text = [NSString stringWithFormat:@"Other\n%.2f%%", [self.helper calculateOtherPercentage:self.vehicle.costs]];
}

-(void)drawRect:(CGRect)rect {
    self.helper = [[HelperCalculations alloc] init];
    float gas = [self.helper calculateGasPercentage:self.vehicle.costs] / 100;
    gasPercent = gas;
    float oil = [self.helper calculateOilPercentage:self.vehicle.costs] / 100;
    oilPercent = oil;
    float other = [self.helper calculateOtherPercentage:self.vehicle.costs] / 100;
    otherPercent = other;
    
    
    CGPoint pieCenter = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    CGFloat radius = pieCenter.y - 40.f;
    
    
    if (gas != 0) {
        UIBezierPath *portionPath = [UIBezierPath bezierPath];
        [portionPath moveToPoint:pieCenter];
        [portionPath addArcWithCenter:pieCenter radius:radius startAngle:0.f endAngle:(M_PI * 2)*gas clockwise:YES];
        [portionPath closePath];
    
        UIColor *red = [UIColor colorWithRed:190.0f/255.0f green:19.0f/255.0f blue:19.0f/255.0f alpha:0.77f];
        [red setFill];
        [portionPath fill];
        
        [self positionGasLabel:(M_PI * 2)*gas radius:radius centerPt:pieCenter startPt:CGPointMake(pieCenter.x + radius, pieCenter.y)];
    } else {
        self.gasPercentage.text = @"";
    }
    

    if (oil != 0) {
        UIBezierPath *portionPath1 = [UIBezierPath bezierPath];
        [portionPath1 moveToPoint:pieCenter];
        [portionPath1 addArcWithCenter:pieCenter radius:radius startAngle:(M_PI * 2) * gas endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas) clockwise:YES];
        [portionPath1 closePath];
        
        [[UIColor blueColor] setFill];
        [portionPath1 fill];
        
        [self positionOilLabel:(M_PI * 2)*gas endAngle:(M_PI * 2 * oil)+(M_PI * 2 * gas) radius:radius centerPt:pieCenter];
    } else {
        self.oilPercentage.text = @"";
    }
    
    if (other != 0) {
        UIBezierPath *portionPath2 = [UIBezierPath bezierPath];
        [portionPath2 moveToPoint:pieCenter];
        [portionPath2 addArcWithCenter:pieCenter radius:radius startAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas) endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas)+(M_PI * 2 * other) clockwise:YES];
        [portionPath2 closePath];
        
        UIColor *green = [UIColor colorWithRed:49.0f/255.0f green:165.0f/255.0f blue:80.0f/255.0f alpha:0.80f];
        [green setFill];
        [portionPath2 fill];
        
        
        [self positionOtherLabel:(M_PI * 2 *oil)+(M_PI * 2 * gas) endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas)+(M_PI * 2 * other) radius:radius centerPt:pieCenter];
    } else {
        self.otherPercentage.text = @"";
    }

 
}







@end
