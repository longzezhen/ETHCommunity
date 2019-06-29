//
//  LYHWebSocketManager.h
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/18.
//  Copyright © 2019 tools. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    LYHSocketStatusConnecting,      // 正在连接
    LYHSocketStatusConnected,       // 已连接
    LYHSocketStatusFailed,          // 失败
    LYHSocketStatusClosedByServer,  // 系统关闭
    LYHSocketStatusClosedByUser,    // 用户关闭
    LYHSocketStatusReceived,        // 接收消息
} LYHSocketStatus;

@interface LYHWebSocketManager : NSObject
/**
 重连时间间隔，默认3秒钟
 */
@property(nonatomic, assign) NSTimeInterval overtime;

/**
 重连次数，默认无限次 -- NSUIntegerMax
 */
@property(nonatomic, assign) NSUInteger reconnectCount;

/**
 当前链接状态
 */
@property(nonatomic, assign) LYHSocketStatus status;

+ (instancetype)sharedInstance;

/**
 开始连接
 */
- (void)connect;

/**
 关闭连接
 */
- (void)close;

/**
 发送一条消息
 
 @param message 消息体
 */
- (void)sendMessage:(NSString *)message;

@end


