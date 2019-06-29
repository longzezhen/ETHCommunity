//
//  BaseViewController.h
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/15.
//  Copyright © 2019 tools. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
- (void)goBackBarButton;//返回按钮
- (void)clickGoBackBarButton;//可覆盖自定义返回方法
-(void)startCountDownWithButton:(UIButton *)button;
@end

NS_ASSUME_NONNULL_END
