//
//  JMBezierPath.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMBezierPath.h"

CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

@implementation JMBezierPath

+ (instancetype)paintWithPoint:(CGPoint)startPoint Color:(UIColor *)color Width:(CGFloat)width
{
    JMBezierPath *path = [[self alloc] init];
    path.lineWidth = width;
    path.color = color;
    [path moveToPoint:startPoint];
    return path;
}

- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    [self addQuadCurveToPoint:midPoint(endPoint, startPoint) controlPoint:startPoint];
}

@end
