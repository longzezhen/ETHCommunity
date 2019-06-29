//
//  AppDelegate.h
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/5/31.
//  Copyright © 2019 tools. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) BaseNavViewController *navigationCtrl;

+ (AppDelegate *)shareAppDelegate;
//跳转选择语言页面
+ (void)startSelectLanguageViewController;
//跳转主界面
+ (void)startMainViewController;
//跳转登录界面
+(void)startLoginViewController;
@end

