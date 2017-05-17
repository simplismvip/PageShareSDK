//
//  JMXmppChatRoom.h
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JMXmppChatRoomDelagate <NSObject>


@end

@interface JMXmppChatRoom : NSObject

@property (nonatomic, strong) XMPPRoomCoreDataStorage *roomStorage;
@property (nonatomic, strong) XMPPRoom *chatRoom;
@property (nonatomic, weak) id <JMXmppChatRoomDelagate>delegate;

// 加入聊天室
- (void)joinRoom:(NSString *)nickName;

// 离开聊天室
- (void)leaveChatRoom;

// 销毁聊天室
- (void)destroyChatRoom;

// 邀请成员到聊天室
- (void)inviteChatRoomUser:(XMPPJID *)jid withMessage:(NSString *)invitationMessage;

// 发送消息到聊天室
- (void)sendMessageChatRoom:(XMPPMessage *)message;

@end
