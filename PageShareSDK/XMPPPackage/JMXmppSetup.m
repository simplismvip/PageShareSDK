//
//  JMXmppSetup.m
//  WeChat
//
//  Created by JM Zhao on 2017/5/10.
//  Copyright © 2017年 ZhaoJM. All rights reserved.
//

#import "JMXmppSetup.h"
#import "JMXmppUserInfo.h"

@interface JMXmppSetup ()<XMPPStreamDelegate>
{
    
    XMPPSetupResultBlack _resultBlack;
    XMPPSetupResultBlack _resignBlack;
    
    // 电子名片的数据存储
    XMPPvCardCoreDataStorage *_vCardStorage;
    
    // 头像模块
    XMPPvCardAvatarModule *_vCardAvatar;
    XMPPReconnect *_reconnect;
}
@end

@implementation JMXmppSetup

// 创建单例类
JMSingleton_implementation(JMXmppSetup)

#pragma mark -- 1> 初始化XMPPStream
- (void)setUpXMPPStream
{
    _xmppStream = [[XMPPStream alloc] init];
    
//    // 创建电子名片模块
//    _vCardStorage = [XMPPvCardCoreDataStorage sharedInstance];
//    _vCard = [[XMPPvCardTempModule alloc] initWithvCardStorage:_vCardStorage];
//    [_vCard activate:_xmppStream];// 激活
    
//    // 头像模块
//    _vCardAvatar = [[XMPPvCardAvatarModule alloc] initWithvCardTempModule:_vCard];
//    [_vCardAvatar activate:_xmppStream];// 激活
    
    // 自动连接模块
    _reconnect = [[XMPPReconnect alloc] init];
    [_reconnect activate:_xmppStream];// 激活
    
//    // 添加花名册模块
//    _rosterStorage = [[XMPPRosterCoreDataStorage alloc] init];
//    _roster = [[XMPPRoster alloc] initWithRosterStorage:_rosterStorage];
//    [_roster activate:_xmppStream];
    
//    // 聊天室模块
//    _roomStorage = [[XMPPRoomCoreDataStorage alloc] init];
//    XMPPJID *roomJID = [XMPPJID jidWithString:[JMXmppUserInfo sharedJMXmppUserInfo].jid];
//    _chatRoom = [[XMPPRoom alloc] initWithRoomStorage:_roomStorage jid:roomJID];
//    [_chatRoom activate:_xmppStream];
    
    // 消息模块
    self.messageArchingStorage = [[XMPPMessageArchivingCoreDataStorage alloc] init];
    self.messageArching = [[XMPPMessageArchiving alloc] initWithMessageArchivingStorage:self.messageArchingStorage];
    [self.messageArching activate:_xmppStream];
    
    // 设置代理
    [_xmppStream addDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
}

#pragma mark -- 2> 连接到服务器
- (void)connectDidToHost
{
    if (!_xmppStream) {
        
        [self setUpXMPPStream];
    }
    
    NSString *user = nil;
    if (self.resign) {
        
        user = [JMXmppUserInfo sharedJMXmppUserInfo].resignUser;
        
    }else {
        // 登陆首先需要从单例获取密码/用户名
        user = [JMXmppUserInfo sharedJMXmppUserInfo].user;
    }
    
    // 登录到相应账户需要设置JID(账户名)和主机名, 端口号
    XMPPJID *jid = [XMPPJID jidWithUser:user domain:[JMXmppUserInfo sharedJMXmppUserInfo].domain resource:[JMXmppUserInfo sharedJMXmppUserInfo].resource];
    _xmppStream.myJID = jid;
    _xmppStream.hostName = [JMXmppUserInfo sharedJMXmppUserInfo].hostName;  // @"10.0.0.37";
    _xmppStream.hostPort =  [JMXmppUserInfo sharedJMXmppUserInfo].hostPort;   // 5222;
    
    NSError *err = nil;
    if (![_xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&err]) {
        
        NSLog(@"%@", err);
    }
}

#pragma mark -- 3> 连接到服务器成功后在发送密码授权
- (void)sendPwdToHost
{
    // 发送密码
    NSError *err = nil;
    NSString *pwd = [JMXmppUserInfo sharedJMXmppUserInfo].pwd;
    [_xmppStream authenticateWithPassword:pwd error:&err];
}

#pragma mark -- 4> 授权成功后发送在线消息
- (void)sendOnlineToHost
{
    XMPPPresence *presence = [XMPPPresence presence];
    [_xmppStream sendElement:presence];
}


#pragma mark -- XMPP代理, 登陆成功/失败代理
- (void)xmppStreamDidConnect:(XMPPStream *)sender
{
    NSLog(@"与主机连接成功");
    
    if (self.resign) {
        
        [_xmppStream registerWithPassword:[JMXmppUserInfo sharedJMXmppUserInfo].resignPwd error:nil];
        
    }else {
        
        [self sendPwdToHost];
    }
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
    NSLog(@"与主机断开连接 %@", error);
    
    if (error && _resultBlack) {
        
        _resultBlack(XMPPSetupResultTypeNetErr);
    }
}


#pragma mark -- XMPP代理, 发送密码授权成功/失败代理
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
    NSLog(@"授权成功");
    
    // 授权成功之后也进行一次回调
    if (_resultBlack) {
        
        _resultBlack(XMPPSetupResultTypeSucess);
    }
    
    // 授权成功后发送在线消息
    [self sendOnlineToHost];
}

- (void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error
{
    NSLog(@"授权失败 %@", error);
    
    if (_resultBlack) {
        
        _resultBlack(XMPPSetupResultTypeFailure);
    }
}

#pragma mark ----- 退出账号 -------
- (void)logOut
{
    // 1> 发送离线消息
    XMPPPresence *offline = [XMPPPresence presenceWithType:@"unavailable"];
    
    [_xmppStream sendElement:offline];
    
    // 2> 与服务器断开连接
    [_xmppStream disconnect];
    
    // 退出登陆之后更改用户的登录状态为YES
    [JMXmppUserInfo sharedJMXmppUserInfo].loginStatus = NO;
    [[JMXmppUserInfo sharedJMXmppUserInfo] saveUserInfoToSanbox];
}

#pragma mark -- ----- 登陆账号 -------
- (void)login:(XMPPSetupResultBlack)resultBlack
{
    [_xmppStream disconnect];
    _resultBlack = resultBlack;
    [self connectDidToHost];
}

#pragma mark ----- 注册账号 -------
- (void)resign:(XMPPSetupResultBlack)resignBlack
{
    [JMXmppUserInfo sharedJMXmppUserInfo].resignPwd = @"000000";
    [JMXmppUserInfo sharedJMXmppUserInfo].resignUser = [NSString stringWithFormat:@"user--%d", arc4random_uniform(10)+5];
    _resign = YES;
    
    [_xmppStream disconnect];
    _resignBlack = resignBlack;
    [self connectDidToHost];
}

//  注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender
{
    NSLog(@"注册成功");
    if (_resign) {
        
        _resignBlack(XMPPSetupResultTypeResignSucess);
    }
    
    _resign = NO;
}

//  注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error
{
    NSLog(@"注册失败");
    if (_resign) {
        
        _resignBlack(XMPPSetupResultTypeResignFailure);
    }
    
    _resign = NO;
}

#pragma mark -- 释放XMPP相关资源
- (void)dealloc
{
    [self tearDownXmpp];
}

- (void)tearDownXmpp
{
    // 1> 移除代理
    [_xmppStream removeDelegate:self];
    
    // 2> 停止代理
    [_reconnect deactivate];
    [_vCard deactivate];
    [_vCardAvatar deactivate];
    [_roster deactivate];
    [_messageArching deactivate];
    
    // 3> 断开连接
    [_xmppStream disconnect];
    
    // 4> 清空资源
    _vCardAvatar = nil;
    _vCard = nil;
    _vCardStorage = nil;
    _reconnect = nil;
    _roster = nil;
    _rosterStorage = nil;
    _messageArching = nil;
    _messageArchingStorage = nil;
    _xmppStream = nil;
}


@end
