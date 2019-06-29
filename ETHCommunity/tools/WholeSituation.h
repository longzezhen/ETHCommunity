//
//  WholeSituation.h
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/15.
//  Copyright © 2019 tools. All rights reserved.
//

//#ifndef WholeSituation_h
//#define WholeSituation_h
//
//
//#endif /* WholeSituation_h */

//屏幕宽高
#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height
//是否是x系列手机
#define KiPhoneXSeries [MYTools iPhoneXSeries]
#define KNavBarHeight (KiPhoneXSeries ? 88 : 64)
#define KTabBarHeight   (KiPhoneXSeries ? 83 : 49)
#define KTopHeight   (KiPhoneXSeries ? 24.f:0.f)
#define KBottomHeight  (KiPhoneXSeries ? 34.f:0.f)
//是否是iPad
#define IS_IPAD  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//圆角
#define LayerMakeCorner(view,radius) {(view).layer.cornerRadius=(radius);(view).layer.masksToBounds=YES;}
//边界
#define LayerMakeBorder(view,_borderWidth,_borderColor) {(view).layer.borderWidth=(_borderWidth);(view).layer.borderColor=(_borderColor);}

#define END_EDITING  [[[[UIApplication sharedApplication] delegate]window] endEditing:YES]

#define ImageNamed(imageName) [UIImage imageNamed:imageName]
#define WEAKSELF typeof(self) __weak weakSelf = self
//color
#define ColorFromRGBA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]
#define ColorFromRGB(rgbValue) ColorFromRGBA(rgbValue, 1.0)

//font
#define KHelvetica @"Helvetica"//统一字体
#define KFont(fontSize)  [UIFont fontWithName:KHelvetica size:fontSize]
#define KUniversCondensed @"Univers-Condensed"//金额字体
#define KFontUniversCondensed(fontSize)    [UIFont fontWithName:kUniversCondensed size:fontSize]
//应用版本号
#define KAPPShortVersion                    ([[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"])

#define KAPPBuildVersion                    ([[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleVersion"])
//主线程执行
#define Main(block) dispatch_async(dispatch_get_main_queue(),block)
//屏幕比例
#define Auto_Width(a)       (((KScreenWidth)/(375))*(a))
#define Auto_Height(a)      (((KScreenHeight)/(667))*(a))

//获取登录token
#define TOKEN    [[NSUserDefaults standardUserDefaults] objectForKey:@"token"]

#define DOCUMENTPATH  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject]
#define USERINFOPATH  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"userInfo.data"]

//给所有文字添加本地化语言方法
//#define L(key)   NSLocalizedString(key, nil);
