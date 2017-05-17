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
@property (nonatomic, weak) UIButton *colors1;
@property (nonatomic, weak) UIButton *colors2;
@property (nonatomic, weak) UIButton *colors3;
@property (nonatomic, weak) UIButton *colors4;
@property (nonatomic, weak) UIButton *colors5;
@property (nonatomic, weak) UIButton *colors6;
@property (nonatomic, assign) BOOL isSelect;
@end

@implementation JMPaintBottom

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.isSelect = NO;
        UIButton *colorBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn.backgroundColor = [UIColor redColor];
        colorBtn.layer.cornerRadius = 15;
        colorBtn.layer.borderWidth = 3;
        colorBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn];
        self.colors = colorBtn;
        
        UIButton *colorBtn1 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn1.backgroundColor = [UIColor blueColor];
        colorBtn1.layer.cornerRadius = 15;
        colorBtn1.layer.borderWidth = 3;
        colorBtn1.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn1 addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn1];
        self.colors1 = colorBtn1;

        
        UIButton *colorBtn2 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn2.backgroundColor = [UIColor blackColor];
        colorBtn2.layer.cornerRadius = 15;
        colorBtn2.layer.borderWidth = 3;
        colorBtn2.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn2 addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn2];
        self.colors2 = colorBtn2;

        
        UIButton *colorBtn3 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn3.backgroundColor = [UIColor grayColor];
        colorBtn3.layer.cornerRadius = 15;
        colorBtn3.layer.borderWidth = 3;
        colorBtn3.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn3 addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn3];
        self.colors3 = colorBtn3;

        
        UIButton *colorBtn4 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn4.backgroundColor = [UIColor cyanColor];
        colorBtn4.layer.cornerRadius = 15;
        colorBtn4.layer.borderWidth = 3;
        colorBtn4.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn4 addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn4];
        self.colors4 = colorBtn4;

        UIButton *colorBtn5 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn5.backgroundColor = [UIColor orangeColor];
        colorBtn5.layer.cornerRadius = 15;
        colorBtn5.layer.borderWidth = 3;
        colorBtn5.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn5 addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn5];
        self.colors5 = colorBtn5;

        
        UIButton *colorBtn6 = [UIButton buttonWithType:(UIButtonTypeSystem)];
        colorBtn6.backgroundColor = [UIColor yellowColor];
        colorBtn6.layer.cornerRadius = 15;
        colorBtn6.layer.borderWidth = 3;
        colorBtn6.layer.borderColor = [UIColor whiteColor].CGColor;
        [colorBtn6 addTarget:self action:@selector(selectColor:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:colorBtn6];
        self.colors6 = colorBtn6;

        self.backgroundColor = JMColor(245, 245, 245);
        UISlider *widthSlider = [[UISlider alloc] init];
        widthSlider.backgroundColor = JMColor(245, 245, 245);
        widthSlider.minimumValue = 3;
        widthSlider.maximumValue = 30;
        widthSlider.value = [JMStaticClass getLineWidth];
        [widthSlider addTarget:self action:@selector(changeValues:) forControlEvents:(UIControlEventValueChanged)];
        [self addSubview:widthSlider];
        self.widthSlider = widthSlider;
        
    }
    return self;
}

- (void)selectColor:(UIButton *)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        
        if (self.isSelect) {
            _widthSlider.alpha = 1.0;
        }else{
            _widthSlider.alpha = 0.0;
        }
    }];
    
    self.isSelect = !self.isSelect;
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
    _colors1.frame = CGRectMake(CGRectGetMinX(_colors.frame)-30, 7, 30, 30);
    _colors2.frame = CGRectMake(CGRectGetMinX(_colors1.frame)-30, 7, 30, 30);
    _colors3.frame = CGRectMake(CGRectGetMinX(_colors2.frame)-30, 7, 30, 30);
    _colors4.frame = CGRectMake(CGRectGetMinX(_colors3.frame)-30, 7, 30, 30);
    _colors5.frame = CGRectMake(CGRectGetMinX(_colors4.frame)-30, 7, 30, 30);
    _colors6.frame = CGRectMake(CGRectGetMinX(_colors5.frame)-30, 7, 30, 30);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
