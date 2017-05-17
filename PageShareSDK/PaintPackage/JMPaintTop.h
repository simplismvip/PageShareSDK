//
//  JMPaintTop.h
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMPaintTopDelegate <NSObject>

- (void)selectionPaint:(NSInteger)type;

@end

@interface JMPaintTop : UIView
@property (nonatomic, weak) id <JMPaintTopDelegate>delegate;
@end
