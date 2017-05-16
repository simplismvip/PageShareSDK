//
//  JMXmppUserInfo.h
//  WeChat
//
//  Created by JM Zhao on 2017/5/10.
//  Copyright © 2017年 ZhaoJM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMSingleton.h"
@interface JMXmppUserInfo : NSObject

JMSingleton_interface(JMXmppUserInfo);

@property (nonatomic, copy) NSString *user;//用户名
@property (nonatomic, copy) NSString *pwd;//密码

@property (nonatomic, copy) NSString *resignUser;
@property (nonatomic, copy) NSString *resignPwd;

@property (nonatomic, copy) NSString *resource;
@property (nonatomic, copy) NSString *domain;
@property (nonatomic, copy) NSString *jid;
@property (nonatomic, copy) NSString *hostName;
@property (nonatomic, assign) NSInteger hostPort;

/**
 *  登录的状态 YES 登录过/NO 注销
 */
@property (nonatomic, assign) BOOL loginStatus;

/**
 *  从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox;

/**
 *  保存用户数据到沙盒
 
 */
-(void)saveUserInfoToSanbox;

@end
