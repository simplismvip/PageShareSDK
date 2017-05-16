//
//  ViewController.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/16.
//  Copyright © 2017年 JunMing. All rights reserved.
//

#import "ViewController.h"
#import "JMXmppMessage.h"
#import "JMXmppSetup.h"
#import "JMXmppChatRoom.h"

@interface ViewController ()<JMXmppMessageDelegate, JMXmppChatRoomDelagate>

@property (strong, nonatomic) IBOutlet UILabel *getMsg;
@property (strong, nonatomic) IBOutlet UITextField *editerMsg;
@property (nonatomic, strong) JMXmppMessage *xmppMsg;
@property (nonatomic, strong) JMXmppChatRoom *chatRoom;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.xmppMsg = [[JMXmppMessage alloc] init];
    self.xmppMsg.delegate = self;
    
    self.chatRoom = [[JMXmppChatRoom alloc] init];
    self.chatRoom.delegate = self;
}

- (IBAction)sendMsg:(id)sender {
    
    [self.xmppMsg sendMessage:self.editerMsg.text toJID:[XMPPJID jidWithString:@"user4@10.0.0.37"] bodyType:@"text"];
}

- (IBAction)login:(id)sender {

    [[JMXmppSetup sharedJMXmppSetup] resign:^(XMPPSetupResultType type) {
        
        switch (type) {
            case XMPPSetupResultTypeResignSucess:
                self.getMsg.text = @"注册账号成功";
                break;
            case XMPPSetupResultTypeResignFailure:
                self.getMsg.text = @"注册账号失败";
                break;
                
            default:
                break;
        }
    }];
}

- (IBAction)logout:(id)sender {

    [[JMXmppSetup sharedJMXmppSetup] logOut];
    self.getMsg.text = @"退出账号成功";
}

- (void)xmppReceive:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    self.getMsg.text = [NSString stringWithFormat:@"收到消息:%@", message.body];
    NSLog(@"receive: %@--Msg: %@",sender.myJID.user, message.body);
}

- (void)xmppSend:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    self.editerMsg.text = @"0";
    NSLog(@"sender: %@--Msg: %@",sender.myJID.user, message.body);
}

// 聊天室功能
- (IBAction)creatChatRoom:(id)sender {
    
    self.chatRoom joinRoom:@"user1"
    
}

- (IBAction)joinChatRoom:(id)sender {
    
    
}

- (IBAction)destoryChatRoom:(id)sender {
    
    
}

- (IBAction)leaveCHatRoom:(id)sender {
    
    
}

- (IBAction)sendMessageToChatRoom:(id)sender {
    
    
}

- (IBAction)invideToChatRoom:(id)sender {
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
