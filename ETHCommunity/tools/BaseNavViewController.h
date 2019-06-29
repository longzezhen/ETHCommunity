//
//  BaseNavViewController.h
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/16.
//  Copyright © 2019 tools. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AnimationType) {
    AnimationTypeFade = 1,                   //淡入淡出
    AnimationTypePush,                       //推挤
    AnimationTypeReveal,                     //揭开
    AnimationTypeMoveIn,                     //覆盖
    AnimationTypeCube,                       //立方体
    AnimationTypeSuckEffect,                 //吮吸
    AnimationTypeOglFlip,                    //翻转
    AnimationTypeRippleEffect,               //波纹
    AnimationTypePageCurl,                   //翻页
    AnimationTypePageUnCurl,                 //反翻页
    AnimationTypeCameraIrisHollowOpen,       //开镜头
    AnimationTypeCameraIrisHollowClose,      //关镜头
};

typedef NS_ENUM(NSInteger, AnimationSubtype) {
    AnimationSubtypeLeft,   //从左
    AnimationSubtypeBottom, //从下
    AnimationSubtypeRight,  //从右
    AnimationSubtypeTop     // 从上
};

@interface BaseNavViewController : UINavigationController

+ (void)pushViewController:(UIViewController *)viewController hiddenBottomWhenPush:(BOOL)hiddenBottomWhenPush animation:(BOOL)animation fromNavigation:(UINavigationController *)navi;

#pragma CATransition动画实现
- (void)PK_navigationTransitionWithType:(AnimationType)type subtype:(AnimationSubtype) subtype;
@end

