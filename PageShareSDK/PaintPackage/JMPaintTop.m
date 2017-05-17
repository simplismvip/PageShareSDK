//
//  JMPaintTop.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMPaintTop.h"
#import "UIView+Extension.h"
#import "JMStaticClass.h"

#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

@interface JMPaintTop()
@property (nonatomic, weak) UIButton *paintType;
@end

@implementation JMPaintTop

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
     
        self.backgroundColor = JMColor(205, 205, 205);
        
        NSArray *array = @[@"返回", @"直线", @"曲线", @"矩形", @"椭圆"];
        
        for (int i = 0; i < array.count; i ++) {
            
            UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            btn.tag = i;
            btn.backgroundColor = JMColor(245, 245, 245);
            btn.tintColor = JMColor(105, 105, 105);
            [btn setTitle:array[i] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(touchAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)touchAction:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(selectionPaint:)]) {
        
        [self.delegate selectionPaint:sender.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int i = 0;
    CGFloat width = self.width/self.subviews.count;
    for (UIView *btn in self.subviews) {
        
        btn.frame = CGRectMake(width*i, 0, width, self.height-1);
        i ++;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
