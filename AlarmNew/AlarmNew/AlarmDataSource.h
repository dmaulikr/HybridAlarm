//
//  AlarmDataSource.h
//  Alarm Clock
//
//  Created by Sunil Rao on 07/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AlarmItem.h"

@class AlarmItem;

@interface sharedInstance : NSObject

@property (nonatomic,strong) NSMutableArray *alarmItem;

+ (instancetype) sharedInstance;
- (void) createEvent:(NSDate *)date customMessage:(NSString *)message withInterval:(NSTimeInterval)interval withDays:(NSMutableArray *)days alertTone:(NSString *)tone activate:(BOOL)acti;
- (NSArray *)allEvents;
- (void)removeItem:(AlarmItem *)item;
@end

