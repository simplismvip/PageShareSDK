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
#import "JMBezierPath.h"
#import "JMStaticClass.h"

@interface JMPaintBoard()<JMPaintTopDelegate>
@property (nonatomic, weak) JMPaintTop *top;
@property (nonatomic, weak) JMPaintBottom *bottom;
@property (nonatomic, strong) JMBezierPath *path;
@property (nonatomic, strong) NSMutableArray *historyData;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger type;
@end

@implementation JMPaintBoard

// 获取触摸点
- (CGPoint)pointWithTouches:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    return [touch locationInView:self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint startPoint = [self pointWithTouches:touches];
    self.path = [JMBezierPath paintWithPoint:startPoint Color:[JMStaticClass getColor] Width:[JMStaticClass getLineWidth]];
    [self.historyData addObject:_path];
    
    // 记录数据
    NSString *point = NSStringFromCGPoint(startPoint);
    [self.data addObject:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint endPoint = [self pointWithTouches:touches];
    [_path moveFromPoint:previousLocation toPoint:endPoint];
    
    // 画线数据
    NSString *pointPrevious = NSStringFromCGPoint(previousLocation);
    [self.data addObject:pointPrevious];
    NSString *point = NSStringFromCGPoint(endPoint);
    [self.data addObject:point];
    
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self];
    CGPoint endPoint = [self pointWithTouches:touches];
    
    NSString *pointPrevious = NSStringFromCGPoint(previousLocation);
    [self.data addObject:pointPrevious];
    
    NSString *point = NSStringFromCGPoint(endPoint);
    [self.data addObject:point];
    
    // 字典字符串
    NSString *dataString = [self pointArray:self.data type:1];
    
    // 发送消息
    if ([self.delegate respondsToSelector:@selector(sendData:)]) {
        
        [self.delegate sendData:dataString];
        [self.data removeAllObjects];
    }
}

// 把之前的全部清空 重新绘制
- (void)drawRect:(CGRect)rect
{
    if (!self.historyData.count) return;
    
    for (JMBezierPath *path in self.historyData) {
        
        if ([path isKindOfClass:[UIImage class]]) {
            
            UIImage *image = (UIImage *)path;
            [image drawAtPoint:CGPointZero];
        }else{
            [path.color set];
            [path stroke];
        }
    }
}

#pragma mark - 清屏
- (void)clearScreen
{
    [self.historyData removeAllObjects];
    [self setNeedsDisplay];
}

#pragma mark - 撤销
- (void)undo
{
    [self.historyData removeLastObject];
    [self setNeedsDisplay];
}

#pragma mark - 设置图片，就把图片画在画板上
- (void)setImage:(UIImage *)image
{
    _image = image;
    [self.historyData addObject:image];
    [self setNeedsDisplay];
}

// 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.historyData = [NSMutableArray array];
        self.data = [NSMutableArray array];
        
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
        
    }else if(type == 5){
    
        [self undo];
    
    }else if(type == 6){
        
        [self clearScreen];
    }
}

// 解析接收到的数据
- (void)paintData:(NSString *)data
{
    NSDictionary *dic = [self parseJSONStringToNSDictionary:data];
    NSArray *dataArr = dic[@"dt"];
    CGFloat width = [dic[@"lw"] floatValue];
    //    NSInteger type = [dic[@"tp"] integerValue];
//    CGFloat alpha = [dic[@"ap"] floatValue];
    UIColor *color = [self getColor:dic[@"lc"]];
    
    CGPoint startPoint = CGPointFromString(dataArr.firstObject);
    self.path = [JMBezierPath paintWithPoint:startPoint Color:color Width:width];
    [self.historyData addObject:_path];
    
    // 记录数据
    NSString *point = NSStringFromCGPoint(startPoint);
    [self.data addObject:point];

    for (int i = 1; i < dataArr.count; i +=2) {
        
        CGPoint pointP = CGPointFromString(dataArr[i]);
        CGPoint pointL = CGPointFromString(dataArr[i+1]);
        [self.path moveFromPoint:pointP toPoint:pointL];
        [self setNeedsDisplay];
        
//        NSString *pointPrevious = NSStringFromCGPoint(pointP);
//        [self.data addObject:pointPrevious];
//        NSString *point = NSStringFromCGPoint(pointL);
//        [self.data addObject:point];
    }
}

// 工具
- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString
{
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    return responseJSON;
}

- (NSString *)pointArray:(NSMutableArray *)data type:(NSInteger)type
{
    NSString *tp = [NSString stringWithFormat:@"%ld", type];
    NSString *lc = [self getRGB:[JMStaticClass getColor]];
    NSString *ap = [NSString stringWithFormat:@"%.2f", [JMStaticClass getAlpha]];
    NSString *lw = [NSString stringWithFormat:@"%.2f", [JMStaticClass getLineWidth]];
    NSDictionary *dic = @{@"tp":tp, @"ap":ap, @"lw":lw, @"lc":lc, @"dt":data};
    return [self dictionaryToJson:dic];
}

- (NSString *)getRGB:(UIColor *)color
{
    NSMutableArray *mRGB = [NSMutableArray arrayWithArray:[[NSString stringWithFormat:@"%@", color] componentsSeparatedByString:@" "]];
    [mRGB removeObjectAtIndex:0];
    if (mRGB.count<4) {
        
        for (int i =0; i <4-mRGB.count+1; i ++) {
            
            [mRGB insertObject:@"0" atIndex:0];
        }
    }
    return [mRGB componentsJoinedByString:@","];
}

- (UIColor *)getColor:(NSString *)rgbS
{
    NSArray *array = [rgbS componentsSeparatedByString:@","];
    CGFloat r = [array[0] floatValue];
    CGFloat g = [array[1] floatValue];
    CGFloat b = [array[2] floatValue];
    CGFloat f = [array[3] floatValue];
    //    JMLog(@"%f, %f, %f", r, g, b);
    return [UIColor colorWithRed:r green:g blue:b alpha:f];;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
