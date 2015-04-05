//
//  GraphicView.m
//  Fuel Tracker
//
//  Created by Eric Hodgins on 2015-04-05.
//  Copyright (c) 2015 Eric Hodgins. All rights reserved.
//

#import "GraphicView.h"

@implementation GraphicView




// A simple Line
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.0, 0.0, 1.0, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    
    CGContextSetStrokeColorWithColor(context, color);
    
    CGContextMoveToPoint(context, 30, 30);
    CGContextAddLineToPoint(context, 20, 20);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
    
    float test[] = {1, 2, 3};
    NSLog(@"%f", test[1]);
}


@end
