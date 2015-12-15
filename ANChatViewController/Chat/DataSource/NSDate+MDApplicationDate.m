//
//  NSDate+string.m
//  Innopolis
//
//  Created by Ezistas Batururimi on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import "NSDate+MDApplicationDate.h"

@implementation NSDate (MDApplicationDate)
+ (NSDate *)dateAsISO8601FromString:(NSString *)date
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
	[dateFormatter setDateFormat: @"dd/MM/yyyy HH:mm"];
	[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
	return [dateFormatter dateFromString:date];
}

+ (NSDate *)dateFromTimeGivenAsString:(NSString *)timeString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
	[dateFormatter setDateFormat: @"HH:mm"];
	[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
	return [dateFormatter dateFromString:timeString];
}

+ (NSDate *)dateFromCalendarDateGivenAsString:(NSString *)timeString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
	[dateFormatter setDateFormat: @"yyyy-MM-dd"];
	[dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
	return [dateFormatter dateFromString:timeString];
}

#pragma mark - Formatters
+ (NSDateFormatter *)md_calendarDateServerFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return dateFormatter;
}

+ (NSDateFormatter *)md_calendarDateToShowFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: @"dd MMMM yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return dateFormatter;
}

+ (NSDateFormatter *)md_chatMessageDateToShowFormatter
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat: @"dd MMMM, HH:mm"];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    return dateFormatter;
}

@end
