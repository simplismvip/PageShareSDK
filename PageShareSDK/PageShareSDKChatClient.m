//
//  PageShareSDKChatClient.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "PageShareSDKChatClient.h"
#import "JMXmppUserInfo.h"
#import "JMXmppSetup.h"
#import "JMStaticClass.h"
#import "JMXmppMessage.h"
#import "JMXmppChatRoom.h"

@interface PageShareSDKChatClient()<JMXmppMessageDelegate, JMXmppChatRoomDelagate>
@property (nonatomic, strong) JMXmppMessage *xmppMsg;
@property (nonatomic, strong) JMXmppChatRoom *chatRoom;
@end

@implementation PageShareSDKChatClient
JMSingleton_implementation(PageShareSDKChatClient)

- (JMXmppMessage *)xmppMsg
{
    if (!_xmppMsg) {
        
        self.xmppMsg = [[JMXmppMessage alloc] init];
        self.xmppMsg.delegate = self;
    }
    
    return _xmppMsg;
}

- (JMXmppChatRoom *)chatRoom
{
    if (!_chatRoom) {
        
        self.chatRoom = [[JMXmppChatRoom alloc] init];
        self.chatRoom.delegate = self;
    }
    
    return _chatRoom;
}

// 连接
- (void)setConnectionProperty:(NSString *)user posswd:(NSString *)pwd resource:(NSString *)resource domain:(NSString *)domain jid:(NSString *)jid hostName:(NSString *)hostName hostPort:(NSInteger)hostPort
{
    [JMXmppUserInfo sharedJMXmppUserInfo].resource = resource;
    [JMXmppUserInfo sharedJMXmppUserInfo].domain = domain;
    [JMXmppUserInfo sharedJMXmppUserInfo].user = user;
    [JMXmppUserInfo sharedJMXmppUserInfo].pwd = pwd;
    [JMXmppUserInfo sharedJMXmppUserInfo].hostName = hostName;
    [JMXmppUserInfo sharedJMXmppUserInfo].hostPort = hostPort;
}

- (void)connect
{
    [[JMXmppSetup sharedJMXmppSetup] login:^(XMPPSetupResultType type) {
        
        if ([self.delegate respondsToSelector:@selector(connectResult:)]) {
            
            [self.delegate connectResult:type];
        }
    }];
}

- (void)disConnect
{
    [[JMXmppSetup sharedJMXmppSetup] logOut];
}

// 发送消息
- (void)sendMessage:(NSString *)message toJID:(XMPPJID *)jid bodyType:(NSString *)bodyType
{
    [self.xmppMsg sendMessage:message toJID:jid bodyType:bodyType];
}

- (void)xmppReceive:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    if ([self.delegate respondsToSelector:@selector(receive:didReceiveMessage:)]) {
        
        [self.delegate receive:sender didReceiveMessage:message];
    }
}

- (void)xmppSend:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    if ([self.delegate respondsToSelector:@selector(sendSuccess:didSendMessage:)]) {
        
        [self.delegate sendSuccess:sender didSendMessage:message];
    }
}

// 群聊
- (void)createChatRoom
{

}

- (void)joinChatRoom
{

}

- (void)leaveChatRoom
{

}

- (void)getRoomOccupants
{

}

- (void)getConferenceRooms
{

}

// VOIP
- (void)connectVOIP
{

}

- (void)disconnectVOIP
{

}

- (void)createChatRoomVOIP
{

}

- (void)joinChatRoomVOIP
{

}

- (void)leaveChatRoomVOIP
{

}

@end
