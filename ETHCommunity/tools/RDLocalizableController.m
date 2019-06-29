//
//  RDLocalizableController.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/21.
//  Copyright © 2019 tools. All rights reserved.
//

#import "RDLocalizableController.h"

static RDLocalizableController *currentLanguage;

@implementation RDLocalizableController

static NSBundle *bundle = nil;

// 获取当前资源文件
+ (NSBundle *)bundle{
    return bundle;
}

// 初始化语言文件
+ (void)initUserLanguage{
    NSString *languageString = [[NSUserDefaults standardUserDefaults] valueForKey:RDLanguageKey];
    if(languageString.length == 0){
        // 获取系统当前语言版本
        NSArray *languagesArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        languageString = languagesArray.firstObject;
        [[NSUserDefaults standardUserDefaults] setValue:languageString forKey:@"userLanguage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    // 避免缓存会出现 zh-Hans-CN 及其他语言的的情况
    if ([[RDLocalizableController chinese] containsObject:languageString]) {
        languageString = [[RDLocalizableController chinese] firstObject]; // 中文
    } else if ([[RDLocalizableController english] containsObject:languageString]) {
        languageString = [[RDLocalizableController english] firstObject]; // 英文
    } else {
        languageString = [[RDLocalizableController chinese] firstObject]; // 其他默认为中文
    }
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:languageString ofType:@"lproj"];
    // 生成bundle
    bundle = [NSBundle bundleWithPath:path];
}

// 英文类型数组
+ (NSArray *)english {
    return @[@"en"];
}

// 中文类型数组
+ (NSArray *)chinese{
    return @[@"zh-Hans", @"zh-Hant"];
}

// 获取应用当前语言
+ (NSString *)userLanguage {
    NSString *languageString = [[NSUserDefaults standardUserDefaults] valueForKey:RDLanguageKey];
    return languageString;
}

// 设置当前语言
+ (void)setUserlanguage:(NSString *)language {
    if([[self userLanguage] isEqualToString:language]) return;
    // 改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:language ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    // 持久化
    [[NSUserDefaults standardUserDefaults] setValue:language forKey:RDLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RDNotificationLanguageChanged object:currentLanguage];
}

@end
