//
//  JMXmppvCardTemp.m
//  WeChat
//
//  Created by JM Zhao on 2017/5/11.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMXmppvCardTemp.h"
#import "XMPPvCardTemp.h"
#import "JMXmppSetup.h"
#import "JMXmppUserInfo.h"

@interface JMXmppvCardTemp ()

@end

@implementation JMXmppvCardTemp

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        XMPPvCardTemp *myvCard = [JMXmppSetup sharedJMXmppSetup].vCard.myvCardTemp;
        // if (myvCard.photo) {self.photo = [UIImage imageWithData:myvCard.photo];}
        
        // 设置昵称
        self.nickName = myvCard.nickname;
        
        // 设置微信号
        self.account = [JMXmppUserInfo sharedJMXmppUserInfo].user;
        
        // 设置相册
        self.orgName = myvCard.orgName;
        
        // 设置保存
        if (myvCard.addresses.count > 0) {self.addresses = myvCard.addresses[0];}
        
        // 这里是有note字段充当电话
        self.note = myvCard.note;
        
        // 这里是有mailer充当邮箱
        self.mailer = myvCard.mailer;
    }
    
    return self;
}

- (void)saveInfo
{
    XMPPvCardTemp *myvCard = [JMXmppSetup sharedJMXmppSetup].vCard.myvCardTemp;
    
    // 保存照片头像
//    myvCard.photo = UIImagePNGRepresentation(self.photo);
    
    // 设置昵称
    myvCard.nickname = self.nickName;
    
    // 设置微信号
    [JMXmppUserInfo sharedJMXmppUserInfo].user = self.account;
    
    // 设置相册
    myvCard.orgName = self.orgName;
    
    // 设置保存
    if (myvCard.orgUnits.count > 0) {
        
        myvCard.orgUnits = @[self.addresses];
    }
    
    myvCard.note = self.note;
    myvCard.mailer = self.mailer;
    
    // 更新所有操作到服务器
    [[JMXmppSetup sharedJMXmppSetup].vCard updateMyvCardTemp:myvCard];
}

//- (void)setPhoto:(UIImage *)photo
//{
//    _photo = photo;
//}

- (void)setNote:(NSString *)note
{
    _note = note;
}

- (void)setNickName:(NSString *)nickName
{
    _nickName = nickName;
}

- (void)setAccount:(NSString *)account
{
    _account = account;
}

- (void)setMailer:(NSString *)mailer
{
    _mailer = mailer;
}

- (void)setAddresses:(NSString *)addresses
{
    _addresses = addresses;
}

- (void)setOrgName:(NSString *)orgName
{
    _orgName = orgName;
}

@end
