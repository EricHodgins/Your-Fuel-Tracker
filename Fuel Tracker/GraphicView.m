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




//// A simple Line
//- (void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2.0);
//    
//    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
//    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
//    CGColorRef color = CGColorCreate(colorspace, components);
//    
//    CGContextSetStrokeColorWithColor(context, color);
//    
//    CGContextMoveToPoint(context, 30, 30);
//    CGContextAddLineToPoint(context, 20, 20);
//    
//    CGContextStrokePath(context);
//    CGColorSpaceRelease(colorspace);
//    CGColorRelease(color);
//    
//    float test[] = {1, 2, 3};
//    NSLog(@"%f", test[1]);
//}

//// Drawing Paths
//-(void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 2.0);
//    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
//    CGContextMoveToPoint(context, 50, 50);
//    CGContextAddLineToPoint(context, 100, 100);
//    CGContextAddLineToPoint(context, 50, 150);
//    CGContextAddLineToPoint(context, 1, 1);
//    CGContextAddLineToPoint(context, 160, 1);
//    CGContextAddLineToPoint(context, 160, 160);
//    CGContextStrokePath(context);
//}


//// Drawing Circles plus filling in with color
//-(void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 4.0);
//    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
//    CGRect rectangle = CGRectMake(60,40,200,80);
//    CGContextAddEllipseInRect(context, rectangle);
//    CGContextStrokePath(context);
//    
//    //Fill in with Red
//    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextFillEllipseInRect(context, rectangle);
//}

// Drawing Arcs
//-(void)drawRect:(CGRect)rect {
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetLineWidth(context, 4.0);
//    CGContextSetStrokeColorWithColor(context,[UIColor blueColor].CGColor);
//    CGContextMoveToPoint(context, 110, 80);
//    CGContextAddArcToPoint(context, 110, 130, 160, 130, 50);
//    CGContextStrokePath(context);
//    
//    CGContextMoveToPoint(context, 108, 80);
//    CGContextAddLineToPoint(context, 160, 80);
//    CGContextAddLineToPoint(context, 160, 132);
//    CGContextStrokePath(context);
//    
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillPath(context);
//}



-(void)drawRect:(CGRect)rect {
    NSLog(@"Vehicle Owner: %@", self.vehicle.owner);
    HelperCalculations *helper = [[HelperCalculations alloc] init];
    float zero = [helper calculateGasPercentage:self.vehicle.costs] / 100;
    float one = [helper calculateOilPercentage:self.vehicle.costs] / 100;
    float two = [helper calculateOtherPercentage:self.vehicle.costs] / 100;
    float separator = (M_PI * 2) / 180;
    
    if ((zero >= 1) || (one >= 1) || (two >= 1)) {
        NSLog(@"Separator: %f, zero: %f, one: %f, two: %f", separator, zero, one, two);
        separator = 0;
    }
    
    
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f, CGRectGetHeight(self.bounds) / 2.f);
    CGFloat radius = center.y - 10.f;
    
    if (zero != 0) {
        UIBezierPath *portionPath = [UIBezierPath bezierPath];
        [portionPath moveToPoint:center];
        [portionPath addArcWithCenter:center radius:radius startAngle:0.f endAngle:(M_PI * 2)*zero - separator clockwise:YES];
        [portionPath closePath];
        
        UIColor *red = [UIColor colorWithRed:190.0f/255.0f green:19.0f/255.0f blue:19.0f/255.0f alpha:0.77f];
        [red setFill];
        [portionPath fill];
    }
    

    if (one != 0) {
        UIBezierPath *portionPath1 = [UIBezierPath bezierPath];
        [portionPath1 moveToPoint:center];
        [portionPath1 addArcWithCenter:center radius:radius startAngle:(M_PI * 2) * zero endAngle:(M_PI * 2 *one)+(M_PI * 2 * zero) - separator clockwise:YES];
        [portionPath1 closePath];
        
        [[UIColor blueColor] setFill];
        [portionPath1 fill];
    }
    
    if (two != 0) {
        UIBezierPath *portionPath2 = [UIBezierPath bezierPath];
        [portionPath2 moveToPoint:center];
        [portionPath2 addArcWithCenter:center radius:radius startAngle:(M_PI * 2 *one)+(M_PI * 2 * zero) endAngle:(M_PI * 2 *one)+(M_PI * 2 * zero)+(M_PI * 2 * two) - separator clockwise:YES];
        
        portionPath2.lineWidth = 4;
        [portionPath2 strokeWithBlendMode:kCGBlendModeDifference alpha:0.8];
        [[UIColor yellowColor] setFill];
        [portionPath2 fill];
    }

 
}

-(void) drawGradient {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient;
    CGColorSpaceRef colorspace;
    CGFloat locations[4] = { 0.0, 0.25, 0.5, 0.75 };
    
    NSArray *colors = @[(id)[UIColor redColor].CGColor,
                        (id)[UIColor greenColor].CGColor,
                        (id)[UIColor blueColor].CGColor,
                        (id)[UIColor yellowColor].CGColor];
    
    colorspace = CGColorSpaceCreateDeviceRGB();
    
    gradient = CGGradientCreateWithColors(colorspace,
                                          (CFArrayRef)colors, locations);
    
    CGPoint startPoint, endPoint;
    startPoint.x = 0.0;
    startPoint.y = 0.0;
    
    endPoint.x = 500;
    endPoint.y = 500;
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
}














@end
