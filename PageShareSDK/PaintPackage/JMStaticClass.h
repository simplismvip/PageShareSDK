//
//  JMStaticClass.h
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMStaticClass : NSObject

+ (void)setNumber:(NSInteger)number;
+ (NSInteger)getNumber;

+ (void)setLineWidth:(CGFloat)linewidth;
+ (CGFloat)getLineWidth;

+ (void)setColor:(UIColor *)color;
+ (UIColor *)getColor;

+ (void)setAlpha:(CGFloat)alpha;
+ (CGFloat)getAlpha;

@end
