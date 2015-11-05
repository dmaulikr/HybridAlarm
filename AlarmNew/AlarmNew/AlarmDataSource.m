//
//  AlarmDataSource.m
//  Alarm Clock
//
//  Created by Sunil Rao on 07/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmDataSource.h"
#import "AlarmItem.h"
#import "CustomAlertMessageTableViewCell.h"



@implementation sharedInstance

/// Creating singleton class.
+ (instancetype) sharedInstance
{
    static sharedInstance *sharedInstance = nil;
    
    if(!sharedInstance)
    {
        sharedInstance = [[self alloc]initPrivate];
    }
    return sharedInstance;
}

- (instancetype) init
{
    @throw [NSException exceptionWithName:@"Singleton" reason:@"use +[ItemObject sharedInstance]" userInfo:nil];
    return nil;
}

- (instancetype) initPrivate
{
    self = [super init];
    if(self)
    {
        self.alarmItem = [[NSMutableArray alloc]init];
      
    }
    return self;
}

///To create an alarm event
- (void) createEvent:(NSDate *)date customMessage:(NSString *)message withInterval:(NSTimeInterval)interval withDays:(NSMutableArray *)days alertTone:(NSString *)tone activate:(BOOL)acti
{
    AlarmItem *event = [[AlarmItem alloc]init];
    event.time = date;
    //event.days = nil;
    event.snoozeTime = interval;
    
    if ([message length] == 0)
    {
        event.customLabel = @"Alarm event";
    }
    else
    {
        event.customLabel = message;
    }
    event.alarmTone = tone;
    event.activate = acti;
    event.days = [[NSMutableArray alloc]initWithArray:days];
    event.interval = [UtilityFunctions timeIntervalFromNowto:date];
    event.notification = [UtilityFunctions addNotificationDate:date alertMessage:message withInterval:interval repeatCalendar:days alertTone:tone activation:acti];
    [self.alarmItem addObject:event];

}

/// To get all the events
- (NSArray *)allEvents
{
    
    if ([self.alarmItem count] <= 1)
    {
        return self.alarmItem;
    }
    else
    {
        for (int i = (int)[self.alarmItem count] - 1 ; i != 0; i--)
        {
            AlarmItem *iPresent = [self.alarmItem objectAtIndex:i ];
            AlarmItem *iPrevious = [self.alarmItem objectAtIndex:(i - 1)];
            
            if ([iPresent.time compare:iPrevious.time] == NSOrderedAscending)
            {
                [self.alarmItem exchangeObjectAtIndex:i-1 withObjectAtIndex:i];
            }
        }
        
        return self.alarmItem;
    }
    
    return self.alarmItem;
}

/// To remove an alarm event
- (void)removeItem:(AlarmItem *)item
{
    [self.alarmItem removeObjectIdenticalTo:item];
    item = nil;
}


@end
