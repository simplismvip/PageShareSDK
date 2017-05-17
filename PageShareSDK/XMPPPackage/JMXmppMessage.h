//
//  JMXmppMessage.h
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JMXmppMessageDelegate <NSObject>
- (void)xmppReceive:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message;
- (void)xmppSend:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message;
@end

@interface JMXmppMessage : NSObject

@property (nonatomic, weak) id<JMXmppMessageDelegate> delegate;

/**
 * 发送消息方法
 */
- (void)sendMessage:(NSString *)message toJID:(XMPPJID *)jid bodyType:(NSString *)bodyType;

/**
 * 加载历史消息
 */
- (NSMutableArray *)loadHistoryAllMessage;
@end
