//
//  LYHWebSocketManager.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/18.
//  Copyright © 2019 tools. All rights reserved.
//

#import "LYHWebSocketManager.h"
#import <SocketRocket/SocketRocket.h>
@interface LYHWebSocketManager()<SRWebSocketDelegate>
@property(nonatomic, strong) SRWebSocket *webSocket;
@property(nonatomic, strong) NSString *urlString;
@property(nonatomic, strong) NSTimer *pingTimer;  //每10秒钟发送一次ping消息
@property(nonatomic, assign) NSUInteger currentCount;  //当前重连次数
@end
@implementation LYHWebSocketManager

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static LYHWebSocketManager *instance = nil;
    dispatch_once(&onceToken,^{
        instance = [[super allocWithZone:NULL] init];
        instance.overtime = 3;
        instance.reconnectCount = NSUIntegerMax;
        
//        // 开启ping定时器
//        instance.pingTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:instance selector:@selector(sendPingMessage) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:instance.pingTimer forMode:NSRunLoopCommonModes];
    });
    return instance;
}

/**
 开始连接
 */
- (void)connect {
    //先关闭
    [self.webSocket close];
    self.webSocket.delegate = nil;
    
    //后开启
    self.webSocket = [[SRWebSocket alloc] initWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"ws://52.198.245.251:8080/ws/quote"]]];
    self.webSocket.delegate = self;
    
    self.status = LYHSocketStatusConnecting;
    
    [self.webSocket open];
}

/**
 关闭连接
 */
- (void)close {
    [self.webSocket close];
    self.webSocket = nil;
}


/**
 重新连接
 */
- (void)reconnect {
    
    if (self.currentCount < self.reconnectCount) {
        
        //计数器+1
        self.currentCount ++;
        
        NSLog(@"%lf秒后进行第%zd次重试连接……",self.overtime,self.currentCount);
        
        [self connect];
    }
    else{
        NSLog(@"重连次数已用完……");
    }
}

/**
 发送一条消息
 @param message 消息体
 */
- (void)sendMessage:(NSString *)message {
    
    if (message) {
        NSError *error;
        if (error) {
            NSLog(@"发送消息失败！");
        }else
        {
            NSLog(@"消息已发送");
        }
    }
}

/**
 发送ping消息
 */
- (void)sendPingMessage {
    [self.webSocket sendPing:[@"123" dataUsingEncoding:NSUTF8StringEncoding]];
}

#pragma mark - SRWebSocketDelegate
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSData *jsonData = [message dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    //NSString * string = [dic objectForKey:@"data"];
    //NSData * data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray * array = [dic objectForKey:@"data"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SRPriceMessage" object:array];
    
}

- (void)webSocketDidOpen:(SRWebSocket *)webSocket {
    
    NSLog(@"已链接服务器：%@",webSocket.url);
    
    //重置计数器
    self.currentCount = 0;
    
    self.status = LYHSocketStatusConnected;
}

- (void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error {
    
    NSLog(@"链接失败：%@",error.localizedDescription);
    
    self.status = LYHSocketStatusFailed;
    
    //尝试重新连接
    [self reconnect];
}

- (void)webSocket:(SRWebSocket *)webSocket didCloseWithCode:(NSInteger)code reason:(nullable NSString *)reason wasClean:(BOOL)wasClean {
    
    NSLog(@"链接已关闭：code:%zd   reason:%@",code,reason);
    
    if (code == SRStatusCodeNormal) {
        self.status = LYHSocketStatusClosedByUser;
    }else
    {
        self.status = LYHSocketStatusClosedByServer;
        
        //尝试重新连接
        [self reconnect];
    }
}


- (void)webSocket:(SRWebSocket *)webSocket didReceivePingWithData:(nullable NSData *)data {
    
    NSLog(@"收到 Ping");
}

- (void)webSocket:(SRWebSocket *)webSocket didReceivePong:(nullable NSData *)pongData {
    
    NSString *str  = [[NSString alloc] initWithBytes:pongData.bytes length:pongData.length encoding:NSUTF8StringEncoding];
    NSLog(@"收到 Pong：%@",str);
}





@end
