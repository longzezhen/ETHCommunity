//
//  NSDate+Category.m
//  ThreeSandOcean
//
//  Created by 龙泽桢 on 2019/5/13.
//  Copyright © 2019 tools. All rights reserved.
//

#import "NSDate+category.h"

@implementation NSDate (category)
//将时间戳转换固定格式时间
+ (NSString *)timestampConversiontime:(NSString *)confromTime Formatter:(NSString *)formatter
{
    //设置格式
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:formatter];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[confromTime integerValue]];
    NSString *confromTimespStr = [format stringFromDate:confromTimesp];
    
    return confromTimespStr;
}

//将某一格式时间转换为另一格式时间
+(NSString *)oneFormatTime:(NSString *)timeString toOtherFormat:(NSString*)formatString
{
    NSDateFormatter * dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formatString];
    NSDate *date = [dateFormat dateFromString:timeString];
    NSString * dateStr = [dateFormat stringFromDate:date];
    return dateStr;
}

/*距离当前的时间间隔描述*/
+(NSString*)timeIntervalDescription:(NSDate*)date
{
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    if (timeInterval < 60) {
        return [NSString stringWithFormat:@"刚刚"];
    }else if (timeInterval < 3600){
        return [NSString stringWithFormat:@"%.f分钟前",timeInterval/60];
    }else if (timeInterval < 86400){
        return [NSString stringWithFormat:@"%.f小时前",timeInterval/3600];
    }else if (timeInterval < 2592000){//30天以内
        return [NSString stringWithFormat:@"%.f天前",timeInterval/86400];
    }else if (timeInterval < 31536000) {//30天至1年内
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"M月d日";
        return [dateFormatter stringFromDate:date];
    } else {
        return [NSString stringWithFormat:@"%.f年前", timeInterval / 31536000.0];
    }
}

/*
 yy: 年的后2位
 
 yyyy: 完整年
 
 MM: 月，显示为1-12
 
 MMM: 月，显示为英文月份简写,如 Jan
 
 MMMM: 月，显示为英文月份全称，如 Janualy
 
 dd: 日，2位数表示，如02
 
 d: 日，1-2位显示，如 2
 
 EEE: 简写星期几，如Sun
 
 EEEE: 全写星期几，如Sunday
 
 aa:上下午，AM/PM（xcode8之前aa表示上下午，之后aa表示am/pm，官方代码看不到，做个提醒，如果你是xcode8之前的编辑器，最好把am／pm转成上下午做，网上有传tt可以代表am／pm，楼主亲测，无效）
 
 H: 时，24小时制，0-23
 
 h(K)：时，12小时制，0-11
 
 m: 分，1-2位
 
 mm: 分，2位
 
 s: 秒，1-2位
 
 ss: 秒，2位
 
 S: 毫秒
 
 */
@end
