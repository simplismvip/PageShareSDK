//
//  JMXmppvCardTemp.h
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 ZhaoJM. All rights reserved.
//

#import <Foundation/Foundation.h>

// myvCard.nickname, [WCUserInfo sharedWCUserInfo].user, myvCard.orgName, myvCard.addresses, myvCard.note, myvCard.mailer

@interface JMXmppvCardTemp : NSObject

//@property (nonatomic, strong) UIImage *photo;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, copy) NSString *mailer;
@property (nonatomic, copy) NSString *addresses;
@property (nonatomic, copy) NSString *orgName;

// 设置个人信息
- (void)saveInfo;
@end
