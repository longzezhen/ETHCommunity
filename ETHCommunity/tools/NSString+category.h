//
//  NSString+category.h
//  LZZTools
//
//  Created by 龙泽桢 on 2019/4/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
@interface NSString (category)
/*
 去掉两端空格：[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
 去掉所有空格：[str stringByReplacingOccurrencesOfString:@" " withString:@""];
 */

//过滤emoji表情
+(NSString*)stringDeleteEmoji:(NSString*)string;
//计算字符串有多少个字节（包含汉字和字符）注：一个汉字两个字节
- (NSInteger)countOfBytes;
//判断某字符串是否为空
+ (BOOL)isBlankString:(NSString *)string;
//是否合法经度
+(BOOL)isLon:(NSString *)string;
//是否合法纬度
+(BOOL)islat:(NSString *)string;
//过滤特殊字符
+(NSString*)deleteSpecialWithString:(NSString*)string;
//md5加密
- (NSString *)MD5String;
@end


