//
//  UIView+category.m
//  ETHCommunity
//
//  Created by 龙泽桢 on 2019/6/6.
//  Copyright © 2019 tools. All rights reserved.
//

#import "UIView+category.h"

@implementation UIView (category)
-(void)showETHtoast:(NSString *)message
{
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.backgroundColor = ColorFromRGB(0x04141E);
    style.messageColor = ColorFromRGB(0x909090);
    [self makeToast:message duration:2 position:CSToastPositionCenter style:style];
}
@end
