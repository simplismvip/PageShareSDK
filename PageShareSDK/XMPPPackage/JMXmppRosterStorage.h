//
//  JMXmppRosterStorage.h
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 ZhaoJM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    RosterStorageResultAccountErr, // 账号不正确
    RosterStorageResultSucess, // 添加好友成功
    RosterStorageResultFailure, // 添加好友失败
    
} XMPPRosterStorage;

@protocol JMXmppRosterStorageDelegate <NSObject>
- (void)addResult:(XMPPRosterStorage)resultType;
@end

@interface JMXmppRosterStorage : NSObject
@property (nonatomic, weak) id <JMXmppRosterStorageDelegate>delegate;

/**
 * 添加好友
 */
- (void)addFriens:(NSString *)name;
@end
