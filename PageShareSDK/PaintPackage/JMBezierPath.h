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
+ (instancetype)paintWithPoint:(CGPoint)startPoint Color:(UIColor *)color Width:(CGFloat)width;
- (void)moveFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint;
@end
