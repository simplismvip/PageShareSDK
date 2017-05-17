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
#import "PageShareSDKChatClient.h"

@interface JMPaintBoardController ()<JMPaintBoardDelegate, PageShareSDKChatClientDelegate>
@property (nonatomic, weak) JMPaintBoard *board;
@end

@implementation JMPaintBoardController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [PageShareSDKChatClient sharedPageShareSDKChatClient].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    JMPaintBoard *board = [[JMPaintBoard alloc] initWithFrame:self.view.bounds];
    board.delegate = self;
    [self.view addSubview:board];
    self.board = board;
}

#pragma mark -- JMPaintBoardDelegate
- (void)dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendData:(NSString *)data
{
    [[PageShareSDKChatClient sharedPageShareSDKChatClient] sendMessage:data toJID:[XMPPJID jidWithString:@"user1@oneplus.com"] bodyType:@"text"];
}

- (void)receive:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message
{
    NSLog(@"boardReceive: %@", message.body);
    [self.board paintData:message.body];
}

- (void)sendSuccess:(XMPPStream *)sender didSendMessage:(XMPPMessage *)message
{
    NSLog(@"boardSend: %@", message.body);
}

- (void)connectResult:(XMPPSetupResultType)result
{
    NSLog(@"boardResult: %d", result);
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
