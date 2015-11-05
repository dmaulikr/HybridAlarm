//
//  UtilityFunctions.m
//  Alarm
//
//  Created by Sunil Rao on 20/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "UtilityFunctions.h"

@implementation UtilityFunctions

/// Finding time interval
+ (NSString *)timeIntervalFromNowto:(NSDate *)date
{
    NSDate *presentDate = [NSDate date];
    
    NSTimeInterval interval = [date timeIntervalSinceDate:presentDate];
    
    //converting NSTimeInterval to NSInteger
    NSInteger sec = interval;
    
    int totalSeconds = (int)sec;
    
    int seconds = abs(totalSeconds % 60);
    int minutes = abs((totalSeconds / 60) % 60);
    int hours = abs(totalSeconds / 3600);
    return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
}

+ (NSTimeInterval )timeIntervalInSeconds:(NSDate *)date
{
    NSDate *presentDate = [NSDate date];
    
    NSTimeInterval interval = [date timeIntervalSinceDate:presentDate];
    
    //converting NSTimeInterval to NSInteger
//    NSInteger sec = interval;
    return interval;
}
+ (UILocalNotification *)addNotificationDate:(NSDate *)fire alertMessage:(NSString *)alert withInterval:(NSCalendarUnit)interval repeatCalendar:(NSMutableArray *)days alertTone:(NSString *)tone activation:(BOOL)activation
{
    if (activation)
    {
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        notification.fireDate = fire;
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.alertBody = alert;
        [notification setAlertTitle:@"Alarm"];
        notification.alertAction = @"Dismiss";
        notification.repeatInterval = interval;
        notification.repeatCalendar = [NSCalendar currentCalendar];
        
        //Adding custom alarm alert tone
        if ([tone isEqualToString:@"default"])
        {
            notification.soundName = UILocalNotificationDefaultSoundName;
            
        }
        else if ([tone isEqualToString:@"alarmTone1.mp3"])
        {
            notification.soundName = @"alarmTone1.mp3";
        }
        else if ([tone isEqualToString:@"alarmTone2.mp3"])
        {
            notification.soundName = @"alarmTone2.mp3";
        }
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];

        //Adding future days notificaitons.
        if ([days count] != 0)
        {
            if ([[UIApplication sharedApplication] scheduledLocalNotifications].count <= 64 )
            {
                for (NSNumber *i in days)
                {
                    if ([i intValue] <= 7)
                    {
                        NSDate *newDate = [fire dateByAddingTimeInterval:+( 86400 * (7 + [i intValue] ))];
                        notification.fireDate = newDate;
                        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
                    }
                }
            }
        }
    
        return notification;
    }
    
    return nil;
}

/// To get the day from the options

+ (NSDate *) getDateOfSpecificDay:(NSInteger )day
{
    NSInteger desiredWeekday = day;
    
    NSRange weekDateRange = [[NSCalendar currentCalendar] maximumRangeOfUnit:NSCalendarUnitWeekday];
    
    NSInteger daysInWeek = weekDateRange.length - weekDateRange.location + 1;
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    NSInteger currentWeekday = dateComponents.weekday;
    NSInteger differenceDays = (desiredWeekday - currentWeekday + daysInWeek) % daysInWeek;

    NSDateComponents *daysComponents = [[NSDateComponents alloc] init];
    daysComponents.day = differenceDays;
    
    NSDate *resultDate = [[NSCalendar currentCalendar] dateByAddingComponents:daysComponents toDate:[NSDate date] options:0];

    return resultDate;
}
@end
