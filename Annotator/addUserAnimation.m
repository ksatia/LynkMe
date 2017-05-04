//
//  addUserAnimation.m
//  Annotator
//
//  Created by Karan Satia on 8/27/16.
//  Copyright © 2016 Karan Satia. All rights reserved.
//

#import "addUserAnimation.h"

@implementation addUserAnimation


+(void)drawShapeInView: (UIView *)view {

    UIBezierPath* bezierPath = UIBezierPath.bezierPath;
    [bezierPath moveToPoint: CGPointMake(99.9, 143.38)];
    [bezierPath addCurveToPoint: CGPointMake(58.26, 101.74) controlPoint1: CGPointMake(99.9, 120.38) controlPoint2: CGPointMake(81.26, 101.74)];
    [bezierPath addCurveToPoint: CGPointMake(16.62, 143.38) controlPoint1: CGPointMake(35.27, 101.74) controlPoint2: CGPointMake(16.63, 120.38)];
    [bezierPath addCurveToPoint: CGPointMake(58.26, 185.02) controlPoint1: CGPointMake(16.62, 166.37) controlPoint2: CGPointMake(35.27, 185.02)];
    [bezierPath addCurveToPoint: CGPointMake(99.9, 143.38) controlPoint1: CGPointMake(81.26, 185.02) controlPoint2: CGPointMake(99.9, 166.37)];
    [bezierPath closePath];
    [bezierPath moveToPoint: CGPointMake(97.67, 160.67)];
    [bezierPath addCurveToPoint: CGPointMake(338.93, 160.67) controlPoint1: CGPointMake(338.96, 160.67) controlPoint2: CGPointMake(338.93, 160.67)];
    [bezierPath addLineToPoint: CGPointMake(338.93, 244.64)];
    [bezierPath addLineToPoint: CGPointMake(45.51, 244.64)];
    [bezierPath addLineToPoint: CGPointMake(45.51, 185.74)];
    bezierPath.usesEvenOddFillRule = YES;
    
    
    
    CAShapeLayer *box = [CAShapeLayer layer];
    box.frame = CGRectMake(0, 0, 500, 500);
    box.path = bezierPath.CGPath;
    box.strokeColor = [UIColor colorWithRed:0.545 green:0.725 blue:0.718 alpha:1].CGColor;
    box.fillColor = [UIColor clearColor].CGColor;
    box.lineWidth = 2.3;
    
    CABasicAnimation *animateBox = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animateBox.duration = 3;
    animateBox.repeatCount = 0;
    animateBox.fromValue = [NSNumber numberWithFloat:0.0f];
    animateBox.toValue = [NSNumber numberWithFloat:1.0f];
    [box addAnimation:animateBox forKey:@"drawBox"];
    
    [view.layer addSublayer:box];
    
}


@end
