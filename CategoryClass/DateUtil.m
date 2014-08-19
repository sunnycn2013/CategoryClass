//
//  DateUtil.m
//  neighborhood
//
//  Created by yijin on 13-11-25.
//  Copyright (c) 2013年 iYaYa. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil

+ (NSString *)getWeekDayNameByDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    NSInteger unitFlags = kCFCalendarUnitWeekday;
    dateComponents = [calendar components:unitFlags fromDate:date];
    
    switch (dateComponents.weekday) {
        case 1:
            return @"星期日";
        case 2:
            return @"星期一";
        case 3:
            return @"星期二";
        case 4:
            return @"星期三";
        case 5:
            return @"星期四";
        case 6:
            return @"星期五";
        case 7:
            return @"星期六";
    }
    
    return @"";
}

+ (NSString *)getDateStringByDate:(NSDate *)date needYear:(BOOL)needYear dateFormatter:(DateFormatter)dateFormatter
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    NSInteger unitFlags = kCFCalendarUnitYear | kCFCalendarUnitMonth | kCFCalendarUnitDay;
    dateComponents = [calendar components:unitFlags fromDate:date];
    
    if (needYear) {
        if (dateFormatter == DateFormatterChineseSplit) {
            return [NSString stringWithFormat:@"%i年%.2i月%.2i日", dateComponents.year, dateComponents.month, dateComponents.day];
        } else if (dateFormatter == DateFormatterSlashSplit) {
            return [NSString stringWithFormat:@"%i/%.2i/%.2i", dateComponents.year, dateComponents.month, dateComponents.day];
        } else if (dateFormatter == DateFormatterDashSplit) {
            return [NSString stringWithFormat:@"%i-%.2i-%.2i", dateComponents.year, dateComponents.month, dateComponents.day];
        } else if (dateFormatter == DateFormatterPoint) {
            return [NSString stringWithFormat:@"%i.%.2i.%.2i", dateComponents.year, dateComponents.month, dateComponents.day];
        }
    } else {
        if (dateFormatter == DateFormatterChineseSplit) {
            return [NSString stringWithFormat:@"%.2i月%.2i日", dateComponents.month, dateComponents.day];
        } else if (dateFormatter == DateFormatterSlashSplit) {
            return [NSString stringWithFormat:@"%.2i/%.2i", dateComponents.month, dateComponents.day];
        } else if (dateFormatter == DateFormatterDashSplit) {
            return [NSString stringWithFormat:@"%.2i-%.2i", dateComponents.month, dateComponents.day];
        } else if (dateFormatter == DateFormatterPoint) {
            return [NSString stringWithFormat:@"%.2i.%.2i", dateComponents.month, dateComponents.day];
        }
    }
    
    return @"";
}

+ (NSInteger)getdateComponentByDate:(NSDate *)date  withUnitFlag:(NSUInteger)unitFlag
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents = [calendar components:unitFlag fromDate:date];
    
    switch (unitFlag) {
        case kCFCalendarUnitYear:
            return dateComponents.year;
        case kCFCalendarUnitMonth:
            return dateComponents.month;
        case kCFCalendarUnitWeekOfYear:
            return dateComponents.weekOfYear;
        case kCFCalendarUnitDay:
            return dateComponents.day;
        case kCFCalendarUnitHour:
            return dateComponents.hour;
        case kCFCalendarUnitMinute:
            return dateComponents.minute;
        case kCFCalendarUnitSecond:
            return dateComponents.second;
    }
    
    return -1;
}

+ (NSDate *)getDateByString:(NSString *)dateString withFormatter:(NSString *)formatter
{
    //yyyy-MM-dd HH:mm:ss
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [dateFormatter dateFromString:dateString];
    
    return date;
}

+ (NSString *)getStringByTimeInterval:(double)timeIntervalValue withFormatter:(NSString *)formatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSString *str = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeIntervalValue]];
    return str;
}

+ (NSDate *)adjustDate:(NSDate *)date
{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

+ (NSString *)getTimeOffset:(double)timeInterval
{
    double oneDaySecond = 24 * 60 * 60;
    
    if (timeInterval > oneDaySecond) {
        int dayOffset = timeInterval / oneDaySecond;
        
        return [NSString stringWithFormat:@"%i天后", dayOffset];
    } else {
        int hour = timeInterval / 3600;
        int minite = (int)timeInterval % 3600 / 60;
        
        if (hour > 0) {
            return [NSString stringWithFormat:@"%i小时%i分钟后", hour, minite];
        } else {
            return [NSString stringWithFormat:@"%i分钟后", minite];
        }
    }
}

+ (NSInteger)getMonthDistanceFromDateString:(NSString *)dateString
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *birthDate = [dateFormatter dateFromString:dateString];
    NSDate *now = [NSDate date];
    
    NSInteger birthMonthCount = [DateUtil getdateComponentByDate:birthDate withUnitFlag:kCFCalendarUnitYear] * 12 + [DateUtil getdateComponentByDate:birthDate withUnitFlag:kCFCalendarUnitMonth];
    NSInteger currentMonthCount = [DateUtil getdateComponentByDate:now withUnitFlag:kCFCalendarUnitYear] * 12 + [DateUtil getdateComponentByDate:now withUnitFlag:kCFCalendarUnitMonth];
    NSInteger monthDistance = currentMonthCount - birthMonthCount;
    
    BOOL hasMonthDayPast = [DateUtil getdateComponentByDate:now withUnitFlag:kCFCalendarUnitDay] >= [DateUtil getdateComponentByDate:birthDate withUnitFlag:kCFCalendarUnitDay];
    if (hasMonthDayPast) {
        monthDistance++;
    }
    
    return monthDistance;
}

+ (NSTimeInterval)getTimeStampByDate:(NSDate *)date
{
    NSTimeInterval time = [date timeIntervalSince1970];
    return time;
}

@end
