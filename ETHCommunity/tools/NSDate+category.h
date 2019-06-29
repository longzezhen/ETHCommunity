//
//  NSDate+Category.h
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/13.
//  Copyright © 2019 tools. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSDate (category)
//将时间戳转换固定格式时间
+ (NSString *)timestampConversiontime:(NSString *)confromTime Formatter:(NSString *)formatter;

//将某一格式时间转换为另一格式时间
+(NSString *)oneFormatTime:(NSString *)timeString toOtherFormat:(NSString*)formatString;

/*距离当前的时间间隔描述*/
+(NSString*)timeIntervalDescription:(NSDate*)date;
@end
