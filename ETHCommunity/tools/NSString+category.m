//
//  NSString+category.m
//  LZZTools
//
//  Created by 龙泽桢 on 2019/4/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "NSString+category.h"

@implementation NSString (category)
/*
 
 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
 
 //不支持系统表情的输入
 if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
 return NO;
 }
 return YES;
 }
 
 */

//过滤emoji表情
+(NSString*)stringDeleteEmoji:(NSString*)string
{
    __block NSString *str = @"";
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        BOOL is_emoji = NO;
        // surrogate pair
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    is_emoji = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                is_emoji = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                is_emoji = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                is_emoji = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                is_emoji = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                is_emoji = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                is_emoji = YES;
            }
        }
        if (!is_emoji) {
            str = [str stringByAppendingString:substring];
        }
    }];
    return str;
}

//计算字符串有多少个字节（包含汉字和字符）注：一个汉字两个字节
- (NSInteger)countOfBytes {
    
    return [self dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)].length;
    
}

//判断某字符串是否为空
+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//是否合法经度
+(BOOL)isLon:(NSString *)string
{
    NSString* number=@"^(\\+|-)?(?:180(?:(?:\\.0{1,6})?)|(?:[0-9]|[1-9][0-9]|1[0-7][0-9])(?:(?:\\.[0-9]{1,6})?))$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:string];
}

//是否合法纬度
+(BOOL)islat:(NSString *)string
{
    NSString* number=@"^(\\+|-)?(?:90(?:(?:\\.0{1,6})?)|(?:[0-9]|[1-8][0-9])(?:(?:\\.[0-9]{1,6})?))$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:string];
}

//过滤特殊字符
+(NSString*)deleteSpecialWithString:(NSString*)string
{
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_//|~＜＞$€^•'@#$%^&*()_+'/"""];
    NSString *resultString = [string stringByTrimmingCharactersInSet:set];
    return resultString;
}

//md5加密
- (NSString *)MD5String {
    const char *cStr = [self UTF8String];
    unsigned char digest[16];
    unsigned int x=(int)strlen(cStr) ;
    CC_MD5( cStr, x, digest );
    // This is the md5 call
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}
@end
