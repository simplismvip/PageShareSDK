//
//  PageShareSDKChatClient.h
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMSingleton.h"
#import "JMXmppSetup.h"

@class JMXmppMessage;
@class JMXmppChatRoom;

@protocol PageShareSDKChatClientDelegate <NSObject>
- (void)receive:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message;
- (void)sendSuccess:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message;
- (void)connectResult:(XMPPSetupResultType)result;
@end

@interface PageShareSDKChatClient : NSObject
@property (nonatomic, weak) id <PageShareSDKChatClientDelegate>delegate;

JMSingleton_interface(PageShareSDKChatClient)
- (void)setConnectionProperty:(NSString *)user posswd:(NSString *)pwd resource:(NSString *)resource domain:(NSString *)domain jid:(NSString *)jid hostName:(NSString *)hostName hostPort:(NSInteger)hostPort;

- (void)connect;
- (void)disConnect;
- (void)sendMessage:(NSString *)message toJID:(XMPPJID *)jid bodyType:(NSString *)bodyType;

// 群聊
- (void)createChatRoom;
- (void)joinChatRoom;
- (void)leaveChatRoom;
- (void)getRoomOccupants;
- (void)getConferenceRooms;

// VOIP
- (void)connectVOIP;
- (void)disconnectVOIP;
- (void)createChatRoomVOIP;
- (void)joinChatRoomVOIP;
- (void)leaveChatRoomVOIP;

@end
