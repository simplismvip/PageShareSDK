//
//  JMPaintBottom.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMPaintBottom.h"
#import "JMStaticClass.h"
#import "UIView+Extension.h"
#define JMColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]

@interface JMPaintBottom()
@property (nonatomic, weak) UISlider *widthSlider;
@property (nonatomic, weak) UIButton *colors;
@end

@implementation JMPaintBottom

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backgroundColor = JMColor(245, 245, 245);
        UISlider *widthSlider = [[UISlider alloc] init];
        widthSlider.minimumValue = 3;
        widthSlider.maximumValue = 30;
        widthSlider.value = [JMStaticClass getLineWidth];
        [widthSlider addTarget:self action:@selector(changeValues:) forControlEvents:(UIControlEventValueChanged)];
        [self addSubview:widthSlider];
        self.widthSlider = widthSlider;
        
        UIButton *colorBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn.backgroundColor = [UIColor redColor];
        colorBtn.layer.cornerRadius = 15;
        colorBtn.layer.borderWidth = 3;
        colorBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn];
        self.colors = colorBtn;
        
    }
    return self;
}

- (void)selectColor:(UIButton *)sender
{
    [JMStaticClass setColor:sender.backgroundColor];
}

- (void)changeValues:(UISlider *)slider
{
    [JMStaticClass setLineWidth:slider.value];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _widthSlider.frame = CGRectMake(0, 0, self.width-44, self.height);
    _colors.frame = CGRectMake(CGRectGetMaxX(_widthSlider.frame)+3, 7, 30, 30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
