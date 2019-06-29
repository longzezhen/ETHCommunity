//
//  RDLocalizableController.h
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/21.
//  Copyright © 2019 tools. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RDLanguageKey @"userLanguage"

#define RDCHINESE @"zh-Hans"

#define RDENGLISH @"en"

#define RDNotificationLanguageChanged @"rdLanguageChanged"

#define L(key)  [[RDLocalizableController bundle] localizedStringForKey:(key) value:@"" table:@"RDLocalizable"]

@interface RDLocalizableController : NSObject

/**
 *  获取当前资源文件
 */
+ (NSBundle *)bundle;
/**
 *  初始化语言文件
 */
+ (void)initUserLanguage;
/**
 *  获取应用当前语言
 */
+ (NSString *)userLanguage;
/**
 *  设置当前语言
 */
+ (void)setUserlanguage:(NSString *)language;

@end
