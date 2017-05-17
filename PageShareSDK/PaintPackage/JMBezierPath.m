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

// 直线
+ (instancetype)paintLineWithPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width
{
    JMBezierPath *path = [self bezierPath];
    path.lineWidth = width;
    path.color = color;
    [path moveToPoint:startPoint];
    [path addLineToPoint:endPoint];
    return path;
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, color.CGColor);
//    CGContextSetLineCap(context, kCGLineCapRound);
//    CGContextSetLineWidth(context, width);
//    CGContextSetAlpha(context, 1.0);
//    
//    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
//    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
//    CGContextStrokePath(context);
}

// 矩形
+ (void)paintRectWithPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 1.0);
    CGRect rectToFill = CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, endPoint.y - startPoint.y);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    CGContextStrokeRect(UIGraphicsGetCurrentContext(), rectToFill);
}

// 椭圆
+ (void)paintEllipseWithPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, 1.0);
    CGRect rectToFill = CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x, endPoint.y - startPoint.y);
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, width);
    CGContextStrokeEllipseInRect(UIGraphicsGetCurrentContext(), rectToFill);
}

- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint
{
    [self addQuadCurveToPoint:midPoint(endPoint, startPoint) controlPoint:startPoint];
}

@end
