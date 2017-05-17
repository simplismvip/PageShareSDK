//
//  JMXmppUserInfo.m
//  WeChat
//
//  Created by JM Zhao on 2017/5/10.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMXmppUserInfo.h"

#define USERKEY @"user"
#define LOGINSTATUSKEY @"LoginStatus"
#define PWDKEY @"pwd"
#define JID @"jid"
#define RESOURCE @"resource"
#define XMPPDOMAIN @"domain"
#define XMPPHOSTNAME @"hostName"
#define XMPPHOSTPORT @"hostPort"

@implementation JMXmppUserInfo

JMSingleton_implementation(JMXmppUserInfo)

-(void)saveUserInfoToSanbox
{    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:USERKEY];
    [defaults setBool:self.loginStatus forKey:LOGINSTATUSKEY];
    [defaults setObject:self.pwd forKey:PWDKEY];
    
    [defaults setObject:self.jid forKey:JID];
    [defaults setObject:self.resource forKey:RESOURCE];
    [defaults setObject:self.domain forKey:XMPPDOMAIN];
    [defaults setObject:self.hostName forKey:XMPPHOSTNAME];
    [defaults setInteger:self.hostPort forKey:XMPPHOSTPORT];
    
    [defaults synchronize];
    
}

-(void)loadUserInfoFromSanbox
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:USERKEY];
    self.loginStatus = [defaults boolForKey:LOGINSTATUSKEY];
    self.pwd = [defaults objectForKey:PWDKEY];
    
    self.jid = [defaults objectForKey:JID];
    self.resource = [defaults objectForKey:RESOURCE];
    self.domain = [defaults objectForKey:XMPPDOMAIN];
    self.hostName = [defaults objectForKey:XMPPHOSTNAME];
    self.hostPort = [defaults integerForKey:XMPPHOSTPORT];
    
}

@end
