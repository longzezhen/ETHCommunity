//
//  MYTools.m
//  LZZTools
//
//  Created by 龙泽桢 on 2019/4/4.
//  Copyright © 2019 tools. All rights reserved.
//

#import "MYTools.h"

@implementation MYTools
#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *)telNumber
{
    if ([telNumber length] == 0) {
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    if (!isMatch) {
        return NO;
    }
    return YES;
    
}

#pragma 正则匹配用户身份证号15或18位
+ (BOOL)validateIdentityCard:(NSString *)identityCard{
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

#pragma 正则匹配邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark - 邮编验证
+ (BOOL)validateZipCode:(NSString *)zipCode
{
    NSString *regex = @"[0-9]\\d{5}(?!\\d)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:zipCode];
    
}

#pragma mark - 是否是x系列手机
+ (BOOL)iPhoneXSeries{
    BOOL iPhoneXSeries = NO;
    if ([UIScreen mainScreen].bounds.size.height >= 812) {
        iPhoneXSeries = YES;
    }
    return iPhoneXSeries;
}

#pragma mark - 当前应用版本号
+ (NSString *)getSystemVersion
{
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    return currentVersion;
}

#pragma mark - 归档用户信息
+(void)saveUserInfo:(ETHUserBaseInfo *)userInfo
{
    [NSKeyedArchiver archiveRootObject:userInfo toFile:USERINFOPATH];

}

#pragma mark - 解档用户信息
+(ETHUserBaseInfo *)getUserInfo
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
}
@end
