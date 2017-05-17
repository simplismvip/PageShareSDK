//
//  JMPaintBoardController.m
//  PageShareSDK
//
//  Created by JM Zhao on 2017/5/17.
//  Copyright © 2017年 奕甲智能 Oneplus Smartware. All rights reserved.
//

#import "JMPaintBoardController.h"
#import "JMPaintBoard.h"
#import "JMXmppMessage.h"
#import "JMXmppSetup.h"

@interface JMPaintBoardController ()<JMPaintBoardDelegate, JMXmppMessageDelegate>
@property (nonatomic, strong) JMXmppMessage *xmppMsg;
@property (nonatomic, weak) JMPaintBoard *board;
@end

@implementation JMPaintBoardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    JMPaintBoard *board = [[JMPaintBoard alloc] initWithFrame:self.view.bounds];
    board.delegate = self;
    [self.view addSubview:board];
    self.board = board;
    
    self.xmppMsg = [[JMXmppMessage alloc] init];
    self.xmppMsg.delegate = self;
}

#pragma mark -- JMXmppMessageDelegate
- (void)xmppReceive:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    [self.board paintData:message.body];
    NSLog(@"receive: %@--Msg: %@",sender.myJID.user, message.body);
}

- (void)xmppSend:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    NSLog(@"sender: %@--Msg: %@",sender.myJID.user, message.body);
}

#pragma mark -- JMPaintBoardDelegate
- (void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendData:(NSString *)data
{
    [self.xmppMsg sendMessage:data toJID:[XMPPJID jidWithString:@"user2@10.0.0.37"] bodyType:@"text"];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
