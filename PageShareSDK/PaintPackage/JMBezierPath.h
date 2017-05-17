//
//  JMBezierPath.h
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMBezierPath : UIBezierPath
@property (nonatomic, strong) UIColor *color;

// 曲线
+ (instancetype)paintWithPoint:(CGPoint)startPoint Color:(UIColor *)color Width:(CGFloat)width;
- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint;

// 直线
+ (instancetype)paintLineWithPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width;

// 矩形
+ (void)paintRectWithPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width;

// 椭圆
+ (void)paintEllipseWithPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint Color:(UIColor *)color Width:(CGFloat)width;
@end
