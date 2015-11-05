//
//  AlarmItem.m
//  Alarm Clock
//
//  Created by Sunil Rao on 07/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmItem.h"

@implementation AlarmItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.time = [[NSDate alloc]init];
        self.days = [[NSMutableArray alloc]init];
        self.interval = [[NSString alloc]init];
        self.customLabel = [[NSString alloc]init];
        self.notification = [[UILocalNotification alloc]init];
        self.alarmTone = [[NSString alloc]init];
    }
    return self;
}
@end
