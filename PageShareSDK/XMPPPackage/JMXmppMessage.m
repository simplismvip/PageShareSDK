//
//  JMXmppMessage.m
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMXmppMessage.h"
#import "JMXmppSetup.h"
#import "JMXmppUserInfo.h"

@interface JMXmppMessage ()<XMPPStreamDelegate>

// 要发送消息的JID
@property (nonatomic, strong) XMPPJID *jid;
@end

@implementation JMXmppMessage

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // 添加代理
        [[JMXmppSetup sharedJMXmppSetup].xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

// 加载历史消息
- (NSMutableArray *)loadHistoryAllMessage
{
    // 拿到上下文找到聊天记录
    NSManagedObjectContext *content = [JMXmppSetup sharedJMXmppSetup].messageArchingStorage.mainThreadManagedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject" inManagedObjectContext:content];
    [fetchRequest setEntity:entity];
    
    // 拿到对应好友的聊天记录
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"bareJidStr == %@", _jid.bare];
    [fetchRequest setPredicate:predicate];
    
    // 按照时间顺序排序
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timestamp" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error = nil;
    NSArray *fetchedObjects = [content executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *messages = [NSMutableArray array];
    if (fetchedObjects != nil){
        
        // 如果读取到的数据为0, 直接返回
        if (fetchedObjects.count > 0) {
        
            for (XMPPMessageArchiving_Message_CoreDataObject *coreDateMessage in fetchedObjects) {
                
                XMPPMessage *message = coreDateMessage.message;
                [messages addObject:message];
            }
        }
    }
    
    return messages;
}

// 发送消息
- (void)sendMessage:(NSString *)message toJID:(XMPPJID *)jid bodyType:(NSString *)bodyType
{
    self.jid = jid;
    
    // 创建消息, 给XML编辑前添加一个属性
    XMPPMessage *sendMessage = [XMPPMessage messageWithType:@"chat" to:jid];
    [sendMessage addAttributeWithName:@"bodyType" stringValue:bodyType];
    [sendMessage addBody:message];
    [[JMXmppSetup sharedJMXmppSetup].xmppStream sendElement:sendMessage];
}

#pragma mark -- XMPPStreamDelegate 收到消息回调
- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    //回执判断
//    NSXMLElement *request = [message elementForName:@"request"];
//    if (request)
//    {
//        if ([request.xmlns isEqualToString:@"urn:xmpp:receipts"])//消息回执
//        {
//            //组装消息回执
//            XMPPMessage *msg = [XMPPMessage messageWithType:[message attributeStringValueForName:@"type"] to:message.from elementID:[message attributeStringValueForName:@"id"]];
//            NSXMLElement *recieved = [NSXMLElement elementWithName:@"received" xmlns:@"urn:xmpp:receipts"];
//            [msg addChild:recieved];
//            
//            //发送回执
//            [[JMXmppSetup sharedJMXmppSetup].xmppStream sendElement:msg];
//        }
//    }else
//    {
//        NSXMLElement *received = [message elementForName:@"received"];
//        if (received)
//        {
//            if ([received.xmlns isEqualToString:@"urn:xmpp:receipts"])//消息回执
//            {
//                //发送成功
//                NSLog(@"message send success!");
//            }
//        }
//    }
    
    // 判断是否发送消息的为同一个人
    if ([sender.myJID.user isEqualToString:[JMXmppUserInfo sharedJMXmppUserInfo].user]) {
        
        // 判断消失是否为空
        if (message.body.length != 0) {
            
            if ([self.delegate respondsToSelector:@selector(xmppReceive:didReceiveMessage:)]) {
                
                [self.delegate xmppReceive:sender didReceiveMessage:message];
            }
        }
    }
}
// 1889117
#pragma mark -- XMPPStreamDelegate 发送消息回调
- (void)xmppStream:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    // 如果发送消息不为空
    if (message.body.length != 0) {
        
        if ([self.delegate respondsToSelector:@selector(xmppSend:didSendMessage:)]) {
            
            [self.delegate xmppSend:sender didSendMessage:message];
        }
    }
}


@end
