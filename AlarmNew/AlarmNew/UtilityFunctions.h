//
//  UtilityFunctions.h
//  Alarm
//
//  Created by Sunil Rao on 20/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UtilityFunctions : NSObject

+ (NSString *)timeIntervalFromNowto:(NSDate *)date;

+ (UILocalNotification *)addNotificationDate:(NSDate *)fire alertMessage:(NSString *)alert withInterval:(NSCalendarUnit)interval repeatCalendar:(NSMutableArray *)days alertTone:(NSString *)tone activation:(BOOL)activation;
+ (NSTimeInterval )timeIntervalInSeconds:(NSDate *)date;


@end
