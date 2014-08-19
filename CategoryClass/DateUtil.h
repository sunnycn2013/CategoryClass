//
//  DateUtil.h
//  neighborhood
//
//  Created by yijin on 13-11-25.
//  Copyright (c) 2013年 iYaYa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DateFormatterChineseSplit,
    DateFormatterSlashSplit,
    DateFormatterDashSplit,
    DateFormatterPoint,
} DateFormatter;

@interface DateUtil : NSObject

+ (NSString *)getWeekDayNameByDate:(NSDate *)date;
+ (NSString *)getDateStringByDate:(NSDate *)date needYear:(BOOL)needYear dateFormatter:(DateFormatter)dateFormatter;
+ (NSInteger)getdateComponentByDate:(NSDate *)date  withUnitFlag:(NSUInteger)unitFlag;

+ (NSDate *)getDateByString:(NSString *)dateString withFormatter:(NSString *)formatter;
+ (NSString *)getStringByTimeInterval:(double)timeIntervalValue withFormatter:(NSString *)formatter;

+ (NSDate *)adjustDate:(NSDate *)date;
+ (NSString *)getTimeOffset:(double)timeInterval;
+ (NSInteger)getMonthDistanceFromDateString:(NSString *)dateString;
+ (NSTimeInterval)getTimeStampByDate:(NSDate *)date;

@end
