//
//  BaseNavViewController.m
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/16.
//  Copyright © 2019 tools. All rights reserved.
//

#import "BaseNavViewController.h"

@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary * dict = @{NSForegroundColorAttributeName:ColorFromRGB(0xFFFFFF),
                            NSFontAttributeName:KFont(18)
                            };
    self.navigationBar.titleTextAttributes = dict;
    self.navigationBar.barStyle = UIBarStyleBlack;
}

+ (void)pushViewController:(UIViewController *)viewController hiddenBottomWhenPush:(BOOL)hiddenBottomWhenPush animation:(BOOL)animation fromNavigation:(UINavigationController *)navi
{
    viewController.hidesBottomBarWhenPushed = hiddenBottomWhenPush;
    [navi pushViewController:viewController animated:animation];
}

#pragma mark Transition动画
- (void)PK_navigationTransitionWithType:(AnimationType)type subtype:(AnimationSubtype) subtype{
    
    [self.view.layer removeAnimationForKey:@"animation"];
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置运动时间
    animation.duration = 0.5;
    //设置运动type
    animation.type = [self animationType:type];
    //设置子类
    //    animation.subtype = [self animtionSubtype:subtype];
    //设置运动速度
    //animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    [self.view.layer addAnimation:animation forKey:@"animation"];
    
}

- (NSString *)animationType:(NSInteger)type{
    
    NSString *animationType = kCATransitionFade;
    switch (type) {
        case AnimationTypeFade:
            animationType = kCATransitionFade;
            break;
            
        case AnimationTypePush:
            animationType = kCATransitionPush;
            break;
            
        case AnimationTypeReveal:
            animationType = kCATransitionReveal;
            break;
        case AnimationTypeMoveIn:
            animationType = kCATransitionMoveIn;
            break;
            
        case AnimationTypeCube:
            animationType = @"cube";
            break;
            
        case AnimationTypeSuckEffect:
            animationType = @"suckEffect";
            break;
            
        case AnimationTypeOglFlip:
            animationType = @"oglFlip";
            break;
            
        case AnimationTypeRippleEffect:
            animationType = @"rippleEffect";
            break;
            
        case AnimationTypePageCurl:
            animationType = @"pageCurl";
            break;
            
        case AnimationTypePageUnCurl:
            animationType = @"pageUnCurl";
            break;
            
        case AnimationTypeCameraIrisHollowOpen:
            animationType = @"cameraIrisHollowOpen";
            break;
            
        case AnimationTypeCameraIrisHollowClose:
            animationType = @"cameraIrisHollowClose";
            break;
    }
    return animationType;
    
}

- (NSString *)animtionSubtype:(NSInteger)subtype{
    
    NSString *subtypeString = kCATransitionFromLeft;
    switch (subtype) {
        case AnimationSubtypeLeft:
            subtypeString = kCATransitionFromLeft;
            break;
        case AnimationSubtypeBottom:
            subtypeString = kCATransitionFromBottom;
            break;
        case AnimationSubtypeRight:
            subtypeString = kCATransitionFromRight;
            break;
        case AnimationSubtypeTop:
            subtypeString = kCATransitionFromTop;
            break;
        default:
            break;
    }
    
    return subtypeString;
    
}
@end
