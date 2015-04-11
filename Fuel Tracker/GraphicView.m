//
//  GraphicView.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-05.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "GraphicView.h"
#import "HelperCalculations.h"

@implementation GraphicView

-(void)drawRect:(CGRect)rect {
    NSLog(@"Vehicle Owner: %@", self.vehicle.owner);
    HelperCalculations *helper = [[HelperCalculations alloc] init];
    float gas = [helper calculateGasPercentage:self.vehicle.costs] / 100;
    float oil = [helper calculateOilPercentage:self.vehicle.costs] / 100;
    float other = [helper calculateOtherPercentage:self.vehicle.costs] / 100;
    
    // For a slight white line that separates each portion (gas, oil, other).
    float separator = (M_PI * 2) / 180;
    
    if ((gas >= 1) || (oil >= 1) || (other >= 1)) {
        NSLog(@"Separator: %f, zero: %f, one: %f, two: %f", separator, gas, oil, other);
        separator = 0;
    }
    
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    CGFloat radius = center.y - 40.f;
    
    if (gas != 0) {
        UIBezierPath *portionPath = [UIBezierPath bezierPath];
        [portionPath moveToPoint:center];
        [portionPath addArcWithCenter:center radius:radius startAngle:0.f endAngle:(M_PI * 2)*gas - separator clockwise:YES];
        [portionPath closePath];
        
        UIColor *red = [UIColor colorWithRed:190.0f/255.0f green:19.0f/255.0f blue:19.0f/255.0f alpha:0.77f];
        [red setFill];
        [portionPath fill];
    }
    

    if (oil != 0) {
        UIBezierPath *portionPath1 = [UIBezierPath bezierPath];
        [portionPath1 moveToPoint:center];
        [portionPath1 addArcWithCenter:center radius:radius startAngle:(M_PI * 2) * gas endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas) - separator clockwise:YES];
        [portionPath1 closePath];
        
        [[UIColor blueColor] setFill];
        [portionPath1 fill];
    }
    
    if (other != 0) {
        UIBezierPath *portionPath2 = [UIBezierPath bezierPath];
        [portionPath2 moveToPoint:center];
        [portionPath2 addArcWithCenter:center radius:radius startAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas) endAngle:(M_PI * 2 *oil)+(M_PI * 2 * gas)+(M_PI * 2 * other) - separator clockwise:YES];
        
        portionPath2.lineWidth = 4;
        [portionPath2 strokeWithBlendMode:kCGBlendModeDifference alpha:0.8];
        [[UIColor greenColor] setFill];
        [portionPath2 fill];
    }

 
}

-(CGRect)positionGasPercentLabel {
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    CGRect frame;
//    frame.origin.x = center.x + (center.y - 35);
//    frame.origin.y = 0;
    frame.origin.x = 250;
    frame.origin.y = 100;
    frame.size.height = 40;
    frame.size.width = 70;
    
    return frame;
}




//-(void) drawGradient {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGGradientRef gradient;
//    CGColorSpaceRef colorspace;
//    CGFloat locations[4] = { 0.0, 0.25, 0.5, 0.75 };
//    
//    NSArray *colors = @[(id)[UIColor redColor].CGColor,
//                        (id)[UIColor greenColor].CGColor,
//                        (id)[UIColor blueColor].CGColor,
//                        (id)[UIColor yellowColor].CGColor];
//    
//    colorspace = CGColorSpaceCreateDeviceRGB();
//    
//    gradient = CGGradientCreateWithColors(colorspace,
//                                          (CFArrayRef)colors, locations);
//    
//    CGPoint startPoint, endPoint;
//    startPoint.x = 0.0;
//    startPoint.y = 0.0;
//    
//    endPoint.x = 500;
//    endPoint.y = 500;
//    
//    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
//}














@end
