//
//  BaseViewController.m
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/15.
//  Copyright © 2019 tools. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
#pragma mark - lifeStyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ColorFromRGB(0x000000);
    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = ColorFromRGB(0x000000);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //侧滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    /* 添加空白图片，去掉NavigationBar下划线 **/
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - public
- (void)goBackBarButton{//返回按钮
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 70, 44);
    leftButton.imageEdgeInsets = UIEdgeInsetsMake(0, -55, 0, 0);
    [leftButton setImage:ImageNamed(@"icon_return") forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(clickGoBackBarButton) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    [self.view endEditing:YES];
}

- (void)clickGoBackBarButton{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)startCountDownWithButton:(UIButton *)button
{
    button.enabled = NO;
    __block int timeout=60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                button.enabled = YES;
                [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                [button setTitleColor:ColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
                button.backgroundColor = ColorFromRGB(0x5979FC);
            });
        }else{
            int seconds = timeout % 60;
            if( seconds == 0)
                seconds = 60;
            NSString *strTime = [NSString stringWithFormat:@"%ds", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [button setTitle:strTime forState:UIControlStateDisabled];
                [button setTitleColor:ColorFromRGB(0x5979FC) forState:UIControlStateNormal];
                button.backgroundColor = ColorFromRGB(0xD8D8D8);
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}
@end
