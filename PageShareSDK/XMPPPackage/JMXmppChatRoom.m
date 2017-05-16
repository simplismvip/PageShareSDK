//
//  JMXmppChatRoom.m
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 ZhaoJM. All rights reserved.
//

#import "JMXmppChatRoom.h"
#import "JMXmppUserInfo.h"
#import "JMXmppSetup.h"

@interface JMXmppChatRoom () <XMPPRoomDelegate>

@end

@implementation JMXmppChatRoom

- (void)creatChatRoom:(NSString *)roomJid
{
    // 聊天室模块
    self.roomStorage = [[XMPPRoomCoreDataStorage alloc] init];
    XMPPJID *roomJID = [XMPPJID jidWithString:[JMXmppUserInfo sharedJMXmppUserInfo].jid];
    self.chatRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:roomJID];
    [_chatRoom activate:[JMXmppSetup sharedJMXmppSetup].xmppStream];
    [_chatRoom addDelegate:self delegateQueue:dispatch_get_main_queue()];
}

// 加入聊天室
- (void)joinRoom:(NSString *)nickName
{
    [_chatRoom joinRoomUsingNickname:nickName history:nil];
}

// 离开聊天室
- (void)leaveChatRoom
{
    [_chatRoom deactivate];
}

// 销毁聊天室
- (void)destroyChatRoom
{
    [_chatRoom destroyRoom];
}

// 邀请成员到聊天室
- (void)inviteChatRoomUser:(XMPPJID *)jid withMessage:(NSString *)invitationMessage
{
    [_chatRoom inviteUser:jid withMessage:invitationMessage];
}

// 发送消息到聊天室
- (void)sendMessageChatRoom:(XMPPMessage *)message
{
    [_chatRoom sendMessage:message];
}

#pragma mark -- XMPPRoomDelegate
- (void)xmppRoomDidCreate:(XMPPRoom *)sender
{
    NSLog(@"创建聊天室成功");
}

// 加入聊天室成功回调
- (void)xmppRoomDidJoin:(XMPPRoom *)sender
{
    // 获取聊天室信息
    [sender fetchConfigurationForm];
    [sender fetchBanList];
    [sender fetchMembersList];
    [sender fetchModeratorsList];
}

- (void)xmppRoomDidLeave:(XMPPRoom *)sender
{
    NSLog(@"离开群聊回调");
}

- (void)xmppRoomDidDestroy:(XMPPRoom *)sender
{
    NSLog(@"销毁群聊房间回调");
}

// 新人加入群聊回调
- (void)xmppRoom:(XMPPRoom *)sender occupantDidJoin:(XMPPJID *)occupantJID withPresence:(XMPPPresence *)presence
{
    NSLog(@"新人加入群聊回调");
}

// 有人退出群聊回调
- (void)xmppRoom:(XMPPRoom *)sender occupantDidLeave:(XMPPJID *)occupantJID withPresence:(XMPPPresence *)presence
{
    NSLog(@"有人退出群聊回调");
}

- (void)xmppRoom:(XMPPRoom *)sender occupantDidUpdate:(XMPPJID *)occupantJID withPresence:(XMPPPresence *)presence
{

}

/**
 * Invoked when a message is received.
 * The occupant parameter may be nil if the message came directly from the room, or from a non-occupant.
 **/
- (void)xmppRoom:(XMPPRoom *)sender didReceiveMessage:(XMPPMessage *)message fromOccupant:(XMPPJID *)occupantJID
{
    NSLog(@"收到群消息回调");
}

// 禁止聊天列表
- (void)xmppRoom:(XMPPRoom *)sender didFetchBanList:(NSArray *)items
{
    NSLog(@"加入聊天室后---获取禁止聊天列表");
}

// 好友列表
- (void)xmppRoom:(XMPPRoom *)sender didFetchMembersList:(NSArray *)items
{
    NSLog(@"加入聊天室后---获取好友列表");
}

// 主持人列表
- (void)xmppRoom:(XMPPRoom *)sender didFetchModeratorsList:(NSArray *)items
{
    NSLog(@"加入聊天室后---获取主持人列表");
}

// 如果房间不存在, 则会回调错误结果
- (void)xmppRoom:(XMPPRoom *)sender didNotFetchBanList:(XMPPIQ *)iqError
{
    NSLog(@"加入聊天室后---获取禁止聊天列表错误");
}

- (void)xmppRoom:(XMPPRoom *)sender didNotFetchMembersList:(XMPPIQ *)iqError
{
    NSLog(@"加入聊天室后---获取好友列表错误");
}

- (void)xmppRoom:(XMPPRoom *)sender didNotFetchModeratorsList:(XMPPIQ *)iqError
{
    NSLog(@"加入聊天室后---获取主持人列表错误");
}

//- (void)xmppRoom:(XMPPRoom *)sender didFetchConfigurationForm:(NSXMLElement *)configForm
//{
//
//}
//
//- (void)xmppRoom:(XMPPRoom *)sender willSendConfiguration:(XMPPIQ *)roomConfigForm
//{
//
//}
//
//- (void)xmppRoom:(XMPPRoom *)sender didConfigure:(XMPPIQ *)iqResult
//{
//
//}
//
//- (void)xmppRoom:(XMPPRoom *)sender didNotConfigure:(XMPPIQ *)iqResult
//{
//
//}

/*
 - (void)fetchConfigurationForm;
 - (void)configureRoomUsingOptions:(NSXMLElement *)roomConfigForm;
 
 - (void)leaveRoom;
 - (void)destroyRoom;
 
 #pragma mark Room Interaction
 
 - (void)changeNickname:(NSString *)newNickname;
 - (void)changeRoomSubject:(NSString *)newRoomSubject;
 
 - (void)inviteUser:(XMPPJID *)jid withMessage:(NSString *)invitationMessage;
 
 - (void)sendMessage:(XMPPMessage *)message;
 
 - (void)sendMessageWithBody:(NSString *)messageBody;
 
 #pragma mark Room Moderation
 
 - (void)fetchBanList;
 - (void)fetchMembersList;
 - (void)fetchModeratorsList;
 
 - (NSString *)editRoomPrivileges:(NSArray *)items;
 
 + (NSXMLElement *)itemWithAffiliation:(NSString *)affiliation jid:(XMPPJID *)jid;
 + (NSXMLElement *)itemWithRole:(NSString *)role jid:(XMPPJID *)jid;
 
 */

@end
