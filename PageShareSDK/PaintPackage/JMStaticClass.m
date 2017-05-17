//
//  JMStaticClass.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMStaticClass.h"

@implementation JMStaticClass

static NSInteger _num;
static CGFloat _lineWidth;
static CGFloat _alpha;
static UIColor *_lineColor;

+ (void)setNumber:(NSInteger)number
{
    _num = number;
}

+ (NSInteger)getNumber
{    
    return _num;
}

+ (void)setLineWidth:(CGFloat)linewidth
{
    _lineWidth = linewidth;
}
+ (CGFloat)getLineWidth
{
    return _lineWidth;
}

+ (void)setColor:(UIColor *)color
{
    _lineColor = color;
}

+ (UIColor *)getColor
{
    return _lineColor;
}

+ (void)setAlpha:(CGFloat)alpha
{
    _alpha = alpha;
}
+ (CGFloat)getAlpha
{
    return _alpha;
}

@end
