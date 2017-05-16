//
//  JMXmppSetup.h
//  WeChat
//
//  Created by JM Zhao on 2017/5/10.
//  Copyright © 2017年 ZhaoJM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMSingleton.h"

// 实现回调
typedef enum {
    
    XMPPSetupResultTypeSucess,// 登陆成功
    XMPPSetupResultTypeFailure,// 登录失败
    XMPPSetupResultTypeNetErr,// 网络错误
    XMPPSetupResultTypeResignSucess,// 注册成功
    XMPPSetupResultTypeResignFailure// 注册失败
    
}XMPPSetupResultType;

typedef void (^XMPPSetupResultBlack)(XMPPSetupResultType type);

@interface JMXmppSetup : NSObject

JMSingleton_interface(JMXmppSetup)

/**
 *标记是否是注册操作, YES为注册, NO为登陆
 */
@property (nonatomic, assign, getter=isResignOpertion) BOOL resign;

// 电子名片
@property (nonatomic, strong) XMPPvCardTempModule *vCard;

// 花名册数据存储
@property (nonatomic, strong) XMPPRosterCoreDataStorage *rosterStorage;

// 花名册模块
@property (nonatomic, strong) XMPPRoster *roster;

//@property (nonatomic, strong) XMPPRoomCoreDataStorage *roomStorage;
//// 聊天室模块
//@property (nonatomic, strong) XMPPRoom *chatRoom;

// 发送聊天数据模块
@property (nonatomic, strong) XMPPMessageArchiving *messageArching;
@property (nonatomic, strong) XMPPMessageArchivingCoreDataStorage *messageArchingStorage;
@property (nonatomic, strong) XMPPStream *xmppStream;

// 用户登录方法
- (void)login:(XMPPSetupResultBlack)resultBlack;

// 用户注册方法
- (void)resign:(XMPPSetupResultBlack)resignBlack;

// 注销
- (void)logOut;

@end
