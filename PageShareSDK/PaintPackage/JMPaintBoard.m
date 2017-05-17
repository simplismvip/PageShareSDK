//
//  JMPaintBoard.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMPaintBoard.h"
#import "JMPaintTop.h"
#import "JMPaintBottom.h"
#import "UIView+Extension.h"

@interface JMPaintBoard()<JMPaintTopDelegate>
@property (nonatomic, weak) JMPaintTop *top;
@property (nonatomic, weak) JMPaintBottom *bottom;
@property (nonatomic, strong) NSMutableArray *historyData;
@property (nonatomic, assign) NSInteger type;
@end

@implementation JMPaintBoard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.historyData = [NSMutableArray array];
        
        JMPaintTop *top = [[JMPaintTop alloc] init];
        top.delegate = self;
        [self addSubview:top];
        self.top = top;
        
        JMPaintBottom *bottom = [[JMPaintBottom alloc] init];
        [self addSubview:bottom];
        self.bottom = bottom;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _top.frame = CGRectMake(0, 0, self.width, 34);
    _bottom.frame = CGRectMake(0, self.height-44, self.width, 44);
}

- (void)selectionPaint:(NSInteger)type
{
    if (type == 0) {
        
        [self.delegate dismissController];
        
    }else {
    
        self.type = type;        
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
