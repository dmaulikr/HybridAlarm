//
//  AlarmItem.h
//  Alarm Clock
//
//  Created by Sunil Rao on 07/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmItem : NSObject

@property (nonatomic,strong) NSDate *time;
@property (nonatomic,strong) NSMutableArray *days;
@property (nonatomic,strong) NSString *interval;
@property (nonatomic,assign) BOOL activate;
@property (nonatomic,strong) NSString *customLabel;
@property (nonatomic,assign) NSTimeInterval snoozeTime;
@property (nonatomic,strong) UILocalNotification *notification;
@property (nonatomic,strong) NSString *alarmTone;

@end
