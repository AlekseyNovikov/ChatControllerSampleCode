//
//  NSDate+string.h
//  Innopolis
//
//  Created by Ezistas Batururimi on 20/05/15.
//  Copyright (c) 2015 Aleksey Novikov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MDApplicationDate)
+ (NSDate *) dateAsISO8601FromString:(NSString *)date;
+ (NSDate *) dateFromTimeGivenAsString:(NSString *) timeString;
+ (NSDate *) dateFromCalendarDateGivenAsString:(NSString *)timeString;
+ (NSDateFormatter *)md_calendarDateServerFormatter;
+ (NSDateFormatter *)md_calendarDateToShowFormatter;
+ (NSDateFormatter *)md_chatMessageDateToShowFormatter;
@end
