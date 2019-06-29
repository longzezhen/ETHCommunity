//
//  ETHUserBaseInfo.h
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/12.
//  Copyright © 2019 tools. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETHUserBaseInfo : NSObject<NSCoding>
@property (nonatomic,strong) NSString * gender;//性别:0:;1:男;2:女;
@property (nonatomic,strong) NSString * headUrl;//头像地址
@property (nonatomic,strong) NSString * inviteCode;//邀请码
@property (nonatomic,strong) NSString * level; //等级,0:普通用户;1:合伙人;2:开元;3:创世
@property (nonatomic,strong) NSString * loginStatus;//用户状态 0:正常;-1:被限制;
@property (nonatomic,strong) NSString * tradeStatus;//交易状态 0:正常;-1:被限制;
@property (nonatomic,strong) NSString * nickName;//昵称
@property (nonatomic,strong) NSString * phone;//手机号码
@property (nonatomic,strong) NSString * userId;//用户id
@property (nonatomic,strong) NSString * username;//用户账号
@property (nonatomic,strong) NSString * words;//助记词
@property (nonatomic,strong) NSString * verifyStatus;//助记词验证状态 0:未验证;1:已验证;

@end

