//
//  JMXmppRosterStorage.m
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 ZhaoJM. All rights reserved.
//

#import "JMXmppRosterStorage.h"
#import "JMXmppSetup.h"
#import "JMXmppUserInfo.h"
#import "XMPPvCardTemp.h"

@interface JMXmppRosterStorage ()<XMPPRosterDelegate>

@end

@implementation JMXmppRosterStorage

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [[JMXmppSetup sharedJMXmppSetup].roster addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    return self;
}

#pragma mark -- UISearchBarDelegate

// 1> 添加好友
- (void)addFriens:(NSString *)userName
{
    // 根据好友名字拿到相应JID
    XMPPJID *jid = [XMPPJID jidWithString:[JMXmppUserInfo sharedJMXmppUserInfo].jid];
    
    // 1> 判断这个账号是否为手机号
    if (![self isTelphoneNum:userName])
    {
        if ([self.delegate respondsToSelector:@selector(addResult:)]) {
            
            [self.delegate addResult:RosterStorageResultAccountErr];
        }
        return;
    }
    
    // 2> 判断是否添加自己
    if([userName isEqualToString:[JMXmppUserInfo sharedJMXmppUserInfo].user])
    {
        if ([self.delegate respondsToSelector:@selector(addResult:)]) {
            
            [self.delegate addResult:RosterStorageResultFailure];
        }
        return;
    }
    
    // 3> 判断是否好友已经存在
    if([[JMXmppSetup sharedJMXmppSetup].rosterStorage userExistsWithJID:jid xmppStream:[JMXmppSetup sharedJMXmppSetup].xmppStream]){
        
        if ([self.delegate respondsToSelector:@selector(addResult:)]) {
            
            [self.delegate addResult:RosterStorageResultFailure];
        }
        
        return;
    }
    
    // 4> 发送请求订阅好友
    if ([self.delegate respondsToSelector:@selector(addResult:)]) {
        
        [[JMXmppSetup sharedJMXmppSetup].roster subscribePresenceToUser:jid];
        [self.delegate addResult:RosterStorageResultSucess];
    }
}

// 2> 删除好友，name为好友账号
- (void)removeBuddy:(NSString *)name
{

#warning mark -- 这里获取jid有问题
    XMPPJID *jid = [XMPPJID jidWithString:[NSString stringWithFormat:@"%@@%@",name, [JMXmppUserInfo sharedJMXmppUserInfo].hostName]];
    [[JMXmppSetup sharedJMXmppSetup].roster removeUser:jid];
}

// [_xmppRoster fetchRoster];//获取好友列表

// 获取到一个好友节点
- (void)xmppRoster:(XMPPRoster *)sender didRecieveRosterItem:(NSXMLElement *)item
{

}

// 获取完好友列表
- (void)xmppRosterDidEndPopulating:(XMPPRoster *)sender
{

}

// 到服务器上请求联系人名片信息
- (void)fetchvCardTempForJID:(XMPPJID *)jid
{

}


// 请求联系人的名片，如果数据库有就不请求，没有就发送名片请求
- (void)fetchvCardTempForJID:(XMPPJID *)jid ignoreStorage:(BOOL)ignoreStorage
{

}

//获取联系人的名片，如果数据库有就返回，没有返回空，并到服务器上抓取
- (XMPPvCardTemp *)vCardTempForJID:(XMPPJID *)jid shouldFetch:(BOOL)shouldFetch
{
    return nil;
}


//更新自己的名片信息
- (void)updateMyvCardTemp:(XMPPvCardTemp *)vCardTemp
{

}

//获取到一盒联系人的名片信息的回调
- (void)xmppvCardTempModule:(XMPPvCardTempModule *)vCardTempModule didReceivevCardTemp:(XMPPvCardTemp *)vCardTemp forJID:(XMPPJID *)jid
{

}


#pragma mark -- XMPPRosterDelegate

// 收到添加好友回调
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence
{
    //取得好友状态
    NSString *presenceType = [NSString stringWithFormat:@"%@", [presence type]]; //online/offline
    
    //请求的用户
    NSString *presenceFromUser =[NSString stringWithFormat:@"%@", [[presence from] user]];
    
    NSLog(@"presenceType:%@",presenceType);
    NSLog(@"presence2:%@  sender2:%@",presence,sender);
    
    XMPPJID *jid = [XMPPJID jidWithString:presenceFromUser];
    
    // 接收添加好友请求
    [[JMXmppSetup sharedJMXmppSetup].roster acceptPresenceSubscriptionRequestFrom:jid andAddToRoster:YES];
    
}

// 这里判断是否输入为电话号码
- (BOOL)isTelphoneNum:(NSString *)str
{
    NSString *telRegex = @"^1[3578]\\d{9}$";
    NSPredicate *prediate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", telRegex];
    return [prediate evaluateWithObject:str];
}

@end
