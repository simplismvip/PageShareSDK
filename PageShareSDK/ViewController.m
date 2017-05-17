//
//  ViewController.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/16.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "ViewController.h"
#import "JMXmppMessage.h"
#import "JMXmppSetup.h"
#import "JMXmppChatRoom.h"
#import "JMPaintBoardController.h"
#import "PageShareSDKChatClient.h"

@interface ViewController () <PageShareSDKChatClientDelegate>

@property (strong, nonatomic) IBOutlet UILabel *getMsg;
@property (strong, nonatomic) IBOutlet UITextField *editerMsg;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PageShareSDKChatClient sharedPageShareSDKChatClient].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)sendMsg:(id)sender
{
    [[PageShareSDKChatClient sharedPageShareSDKChatClient] sendMessage:self.editerMsg.text toJID:[XMPPJID jidWithString:@"user1@oneplus.com"] bodyType:@"text"];
}

- (void)receive:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    self.getMsg.text = [NSString stringWithFormat:@"receive: %@", message.body];
    NSLog(@"receive: %@", message.body);
}

- (void)sendSuccess:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    self.getMsg.text = [NSString stringWithFormat:@"send: %@", message.body];
    NSLog(@"send: %@", message.body);
}

- (void)connectResult:(XMPPSetupResultType)result
{
    NSLog(@"result: %d", result);
}

// 打开画板
- (IBAction)invideToChatRoom:(id)sender {
    
    // [[PageShareSDKChatClient sharedPageShareSDKChatClient] disConnect];
    JMPaintBoardController *paint = [[JMPaintBoardController alloc] init];
    [self presentViewController:paint animated:YES completion:nil];
}

- (IBAction)logout:(id)sender {
    
    [[PageShareSDKChatClient sharedPageShareSDKChatClient] disConnect];
    
    self.getMsg.text = @"退出账号成功";
}

// 注册
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
