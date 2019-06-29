//
//  AppDelegate.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/5/31.
//  Copyright © 2019 tools. All rights reserved.
//

#import "AppDelegate.h"
#import "ETHSelectLanguageViewController.h"
#import "ETHMainTabBarController.h"
#import <AFNetworkActivityLogger/AFNetworkActivityLogger.h>
#import "ETHRegisterViewController.h"
#import "ETHLoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:self.navigationCtrl];
    self.window.backgroundColor = ColorFromRGB(0xFFFFFF);
    [self.window makeKeyAndVisible];
    
    //日志打印
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    [[AFNetworkActivityLogger sharedLogger] setLogLevel:AFLoggerLevelDebug];
    
    //app内部更改语言
    // 语言初始化
    [RDLocalizableController initUserLanguage];
    // 监控语言切换
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChange:) name:RDNotificationLanguageChanged object:nil];
 
    
    //是否进欢迎页面
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"notFirstLaunch"] boolValue]) {
        //第一次运行进入选择语言页面
        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"notFirstLaunch"];
        [AppDelegate startSelectLanguageViewController];
    }else{
        if (TOKEN) {
            [AppDelegate startMainViewController];
        }else{
            [AppDelegate startLoginViewController];
        }
    }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:RDNotificationLanguageChanged object:nil];
}

#pragma mark - private
- (void)languageChange:(NSNotification *)note{
    // 在该方法里实现重新初始化 rootViewController 的行为，并且所有带有文字的页面都要重新渲染
    // 比如：[UIApplication sharedApplication].keyWindow.rootViewController = ...;
    ETHSelectLanguageViewController * vc = [[ETHSelectLanguageViewController alloc] init];
    ETHRegisterViewController * regVC = [ETHRegisterViewController new];
    [self.navigationCtrl setNavigationBarHidden:YES];
    self.navigationCtrl.viewControllers = @[vc,regVC];
}
- (void)changeLanguage{
    // 在该方法里实现重新初始化 rootViewController 的行为，并且所有带有文字的页面都要重新渲染
    // 比如：[UIApplication sharedApplication].keyWindow.rootViewController = ...;
    ETHSelectLanguageViewController * vc = [[ETHSelectLanguageViewController alloc] init];
    ETHRegisterViewController * regVC = [ETHRegisterViewController new];
    [self.navigationCtrl setNavigationBarHidden:YES];
    self.navigationCtrl.viewControllers = @[vc,regVC];
}

#pragma mark - public
//跳转选择语言页面
+ (void)startSelectLanguageViewController
{
    ETHSelectLanguageViewController * vc = [[ETHSelectLanguageViewController alloc] init];
    [[self shareAppDelegate].navigationCtrl setNavigationBarHidden:YES];
    [self shareAppDelegate].navigationCtrl.viewControllers = @[vc];
}

//跳转登录页面
+ (void)startLoginViewController
{
    ETHSelectLanguageViewController * vc = [[ETHSelectLanguageViewController alloc] init];
    ETHRegisterViewController * regVC = [ETHRegisterViewController new];
    ETHLoginViewController * loginVC = [ETHLoginViewController new];
    [[self shareAppDelegate].navigationCtrl setNavigationBarHidden:YES];
    [self shareAppDelegate].navigationCtrl.viewControllers = @[vc,regVC,loginVC];
}

//跳转主页面
+ (void)startMainViewController
{
    ETHMainTabBarController *tabbarVC = [[ETHMainTabBarController alloc]init];
    [[AppDelegate shareAppDelegate].navigationCtrl setNavigationBarHidden:YES];
    [self shareAppDelegate].navigationCtrl.viewControllers = @[tabbarVC];
    
}

#pragma mark - get
- (BaseNavViewController *)navigationCtrl{
    
    if (!_navigationCtrl) {
        _navigationCtrl = [[BaseNavViewController alloc]init];
        [_navigationCtrl setNavigationBarHidden:YES];
    }
    return _navigationCtrl;
}

+ (AppDelegate *)shareAppDelegate{
    
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
@end
