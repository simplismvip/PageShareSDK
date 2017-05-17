//
//  JMPaintBoard.h
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMPaintBoardDelegate <NSObject>
- (void)dismissController;
- (void)sendData:(NSString *)data;
@end

@interface JMPaintBoard : UIView
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak) id <JMPaintBoardDelegate>delegate;
- (void)paintData:(NSString *)data;
@end
