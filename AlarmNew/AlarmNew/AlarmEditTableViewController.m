//
//  AlarmEditTableViewController.m
//  Alarm
//
//  Created by Sunil Rao on 12/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmEditTableViewController.h"
#import "AlarmClockTableViewCell.h"
#import "ButtonTableViewCell.h"
#import "AlarmItem.h"
#import "AlarmDataSource.h"
#import "SnoozeTimeTableViewCell.h"
#import "AlarmDaysTableViewCell.h"
#import "CustomAlertMessageTableViewCell.h"
#import "AlarmToneTableViewCell.h"


@interface AlarmEditTableViewController ()

@property (nonatomic,strong) sharedInstance *dataSource;
@property (nonatomic,strong) AlarmClockTableViewCell *datePicker;
@property (nonatomic,strong) ButtonTableViewCell *button;
@property (nonatomic,strong) SnoozeTimeTableViewCell *snoozeView;
@property (nonatomic,strong) AlarmDaysTableViewCell *daysView;
@property (nonatomic,strong) CustomAlertMessageTableViewCell *labelView;
@property (nonatomic,strong) AlarmToneTableViewCell *AlarmToneview;
@property (nonatomic,strong) NSIndexPath *index;
@property (nonatomic,assign) BOOL edit;
@property (nonatomic,strong) UITableViewCell *cellCopy;
@property (nonatomic,assign) NSCalendarUnit repeatInterval;
@property (nonatomic,strong) NSMutableArray *daysArray;
@property (nonatomic,assign) BOOL mon;
@property (nonatomic,assign) BOOL tue;
@property (nonatomic,assign) BOOL wed;
@property (nonatomic,assign) BOOL thu;
@property (nonatomic,assign) BOOL fri;
@property (nonatomic,assign) BOOL sat;
@property (nonatomic,assign) BOOL sun;
@property (nonatomic,strong) NSString *alarmTone;
@property (nonatomic,strong) UIScrollView *scrollView;

//@property (nonatomic,strong) AVAudioPlayer *audio;

@end

@implementation AlarmEditTableViewController
@synthesize scrollView;

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // Initialization
        self.dataSource = [sharedInstance sharedInstance];
        self.datePicker = [[AlarmClockTableViewCell alloc] init];
        self.button = [[ButtonTableViewCell alloc] init];
        self.snoozeView = [[SnoozeTimeTableViewCell alloc] init];
        self.daysView = [[AlarmDaysTableViewCell alloc] init];
        self.labelView = [[CustomAlertMessageTableViewCell alloc]init];
        self.AlarmToneview = [[AlarmToneTableViewCell alloc]init];
        self.daysArray = [[NSMutableArray alloc]init];
        self.alarmTone = [[NSString alloc]init];
        
        self.labelView.customMessageTextField.delegate = self;
        
        self.edit = NO;
        self.index = NULL;
        self.tableView.bounces = NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    
    if (self.edit)
    {
        NSArray *dataSource = [[sharedInstance sharedInstance]allEvents];
        AlarmItem *item = [dataSource objectAtIndex:self.index.row];
        self.datePicker.datePicker.date = item.time;

        //Enable Cancel(Delete) Button
        self.button.cancelButton.enabled = YES;
        [self.button.cancelButton setTitleColor:DELETE_BUTTON_COLOR_ACTIVE forState:UIControlStateNormal];
        [self.button.cancelButton addTarget:self action:@selector(deleteEvent) forControlEvents:UIControlEventTouchUpInside];
        
        //Disable Add button
        self.button.addButton.hidden = YES;
        self.button.addButton.enabled = NO;
        
        //Enable update button
        self.button.updateButton.hidden = NO;
        self.button.updateButton.enabled = YES;
        [self.button.updateButton addTarget:self action:@selector(updateEvent) forControlEvents:UIControlEventTouchUpInside];
        
        // Get the event snooze time selection
        if (item.snoozeTime == 0)
        {
            [self snoozeButtonSelected:self.snoozeView.dontRepeatButton];
        }
        else if (item.snoozeTime == NSCalendarUnitMinute)
        {
            [self snoozeButtonSelected:self.snoozeView.everyMinuteButton];
        }
        else if (item.snoozeTime == NSCalendarUnitHour)
        {
            [self snoozeButtonSelected:self.snoozeView.everyHourButton];
        }
        
        //Get the event custom message text
        self.labelView.customMessageTextField.text = item.customLabel;
        
        // Get the event Days selection
        [self deactivateAllDaysButton];
        NSArray *days = [item.days copy];

        for (NSNumber *day in days)
        {
            if ([day intValue] == 1)
            {
                [self dayButtonSelected:self.daysView.mondayButton];
            }
            
            else if ([day intValue] == 2)
            {
                [self dayButtonSelected:self.daysView.tuesdayButton];
            }
            
            else if ([day intValue] == 3)
            {
                [self dayButtonSelected:self.daysView.wednesdayButton];
            }
            
            else if ([day intValue] == 4)
            {
                [self dayButtonSelected:self.daysView.thrusdayButton];
            }
            
            else if ([day intValue] == 5)
            {
                [self dayButtonSelected:self.daysView.fridayButton];
            }
            
            else if ([day intValue] == 6)
            {
                [self dayButtonSelected:self.daysView.saturdayButton];
            }
            
            else if ([day intValue] == 7)
            {
                [self dayButtonSelected:self.daysView.sundayButton];
            }
        }
        
        //Get alarm tone of the event
        if ([item.alarmTone isEqualToString:@"default"])
        {
            [self alarmToneButtonSelected:self.AlarmToneview.alarmToneDefaultButton];
        }
        else if ([item.alarmTone isEqualToString:@"alarmTone1.mp3"])
        {
            [self alarmToneButtonSelected:self.AlarmToneview.alarmTone1Button];
        }
        else if ([item.alarmTone isEqualToString:@"alarmTone1.mp3"])
        {
            [self alarmToneButtonSelected:self.AlarmToneview.alarmTone2Button];
        }
    }
    
    else
    {
        NSDate *presentDate = [NSDate date];
        self.datePicker.datePicker.date = presentDate;
        
        self.button.addButton.hidden = NO;
        self.button.addButton.enabled = YES;
        
        self.button.updateButton.hidden = YES;
        self.button.updateButton.enabled = NO;
        [self.button.cancelButton setTitleColor:DELETE_BUTTON_COLOR_DEACTIVE forState:UIControlStateNormal];
        self.button.cancelButton.enabled = NO;
        
        self.labelView.customMessageTextField.text = NULL;
        
        [self snoozeButtonSelected:self.snoozeView.dontRepeatButton];
        [self alarmToneButtonSelected:self.AlarmToneview.alarmToneDefaultButton];
    }
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    switch (indexPath.row)
    {
        case 0:
            cell = self.datePicker;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
         
        case 1:
            cell = self.snoozeView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.snoozeView.dontRepeatButton addTarget:self action:@selector(snoozeButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.snoozeView.everyMinuteButton addTarget:self action:@selector(snoozeButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.snoozeView.everyHourButton addTarget:self action:@selector(snoozeButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            break;
        
        case 2:
            cell = self.daysView;
            [self.daysView.mondayButton addTarget:self action:@selector(dayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.daysView.tuesdayButton addTarget:self action:@selector(dayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.daysView.wednesdayButton addTarget:self action:@selector(dayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.daysView.thrusdayButton addTarget:self action:@selector(dayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.daysView.fridayButton addTarget:self action:@selector(dayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.daysView.saturdayButton addTarget:self action:@selector(dayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.daysView.sundayButton addTarget:self action:@selector(dayButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            break;
        
        case 3:
            cell = self.labelView;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        
        case 4:
            cell = self.AlarmToneview;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self.AlarmToneview.alarmToneDefaultButton addTarget:self action:@selector(alarmToneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.AlarmToneview.alarmTone1Button addTarget:self action:@selector(alarmToneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
            [self.AlarmToneview.alarmTone2Button addTarget:self action:@selector(alarmToneButtonSelected:) forControlEvents:UIControlEventTouchUpInside];

            break;
            
        case 5:
            [self.button.addButton addTarget:self action:@selector(addAlarmEvent) forControlEvents:UIControlEventTouchUpInside];
            self.button.cancelButton.enabled = NO;
            cell = self.button;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
            
        default:
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        return self.view.frame.size.height * 0.30;
    }
    
    else
    {
        return self.view.frame.size.height * 0.12;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

/// Creating event
- (void) addAlarmEvent
{
    [self createDays];
    
    [self.dataSource createEvent:self.datePicker.datePicker.date customMessage:self.labelView.customMessageTextField.text withInterval:self.repeatInterval withDays:self.daysArray alertTone:self.alarmTone activate:YES];
    [self.delegate notifyBool:YES withTitle:[NSString stringWithFormat:@"Alarm is %@ from now",[self timeIntervalFromNowto:self.datePicker.datePicker.date]]];
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
/// Update Event
- (void)updateEvent
{
    // Getting the data of existing event and updating it
    NSArray *dataSource = [self.dataSource allEvents];
    AlarmItem *item = [dataSource objectAtIndex:self.index.row];
    item.time = self.datePicker.datePicker.date;
    
    item.interval = [UtilityFunctions timeIntervalFromNowto:self.datePicker.datePicker.date];
    item.snoozeTime = self.repeatInterval;
    
    if ([self.labelView.customMessageTextField.text length] == 0)
    {
        item.customLabel = @"Alam event";
    }
    else
    {
        item.customLabel = self.labelView.customMessageTextField.text;
    }
    
    
    item.activate = YES;
    [self createDays];
    item.days = nil;
    item.days = [[NSMutableArray alloc]initWithArray:self.daysArray];
    
    item.alarmTone = self.alarmTone;
    
    [[UIApplication sharedApplication] cancelLocalNotification:item.notification];
    item.notification = [UtilityFunctions addNotificationDate:self.datePicker.datePicker.date alertMessage:self.labelView.customMessageTextField.text withInterval:self.repeatInterval repeatCalendar:item.days alertTone:self.alarmTone activation:item.activate];
    
    self.edit = NO;
    self.index = NULL;
//    [self deactivateAllDaysButton];
    [self.delegate notifyBool:YES withTitle:[NSString stringWithFormat:@"Alarm is %@ from now",[self timeIntervalFromNowto:self.datePicker.datePicker.date]]];
    [self.navigationController popToRootViewControllerAnimated:YES];

}

/// Delete Event
- (void) deleteEvent
{
    NSArray *dataSource = [self.dataSource allEvents];
    
    AlarmItem *item = [dataSource objectAtIndex:self.index.row];
    [self.dataSource removeItem:item];
    
    self.edit = NO;
    self.index = NULL;
    //[self deactivateAllDaysButton];
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[UIApplication sharedApplication] cancelLocalNotification:item.notification];
}


- (void) didEdit:(BOOL)edit index:(NSIndexPath *)index;
{
    self.edit = edit;
    self.index = index;
}

// Finding time interval
- (NSString *)timeIntervalFromNowto:(NSDate *)date
{
    NSDate *presentDate = [NSDate date];
    
    NSTimeInterval interval = [date timeIntervalSinceDate:presentDate];
    
    //converting NSTimeInterval to NSInteger
    NSInteger sec = interval;
    
    int totalSeconds = (int)sec;
    
    int seconds = abs(totalSeconds % 60);
    int minutes = abs((totalSeconds / 60) % 60);
    int hours = abs(totalSeconds / 3600);
    
    /// Converting "hours" to "days" if it is more than 12 hours. 
    int day;
    for (day = 0; hours >= 24; day++)
    {
        hours = hours - 24;
    }
    
    if (day == 1)
    {
        return [NSString stringWithFormat:@"%d day %02d:%02d:%02d",day,hours,minutes,seconds];
    }
    else if (day > 1)
    {
        return [NSString stringWithFormat:@"%d days %02d:%02d:%02d",day,hours,minutes,seconds];
    }
    else
    {
        return [NSString stringWithFormat:@"%02d:%02d:%02d",hours, minutes, seconds];
    }
    
}

#pragma mark - snooze button actions

/// Selecting snooze time
- (void) snoozeButtonSelected:(UIButton *)sender
{
    // selecting everySecond button
    if (sender == self.snoozeView.dontRepeatButton)
    {
        [[sender layer] setBorderWidth:2.0f];
        sender.layer.cornerRadius = 10;
        sender.clipsToBounds = YES;
        [[sender layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
        [sender setTitleColor:SNOOZE_BUTTON_SELECTION_COLOR forState:UIControlStateNormal];
        
        [[self.snoozeView.everyMinuteButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.snoozeView.everyMinuteButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        [[self.snoozeView.everyHourButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.snoozeView.everyHourButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.repeatInterval = 0;
    }
    
    //selecting everyMinute Button
    else if (sender == self.snoozeView.everyMinuteButton)
    {
        [[sender layer] setBorderWidth:2.0f];
        sender.layer.cornerRadius = 10;
        sender.clipsToBounds = YES;
        [[sender layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
        [sender setTitleColor:SNOOZE_BUTTON_SELECTION_COLOR forState:UIControlStateNormal];
        
        [[self.snoozeView.dontRepeatButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.snoozeView.dontRepeatButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        [[self.snoozeView.everyHourButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.snoozeView.everyHourButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.repeatInterval = NSCalendarUnitMinute;
    }
    
    //selecting everyHour button
    else if (sender == self.snoozeView.everyHourButton)
    {
        [[sender layer] setBorderWidth:2.0f];
        sender.layer.cornerRadius = 10;
        sender.clipsToBounds = YES;
        [[sender layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
        [sender setTitleColor:SNOOZE_BUTTON_SELECTION_COLOR forState:UIControlStateNormal];
        
        [[self.snoozeView.everyMinuteButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.snoozeView.everyMinuteButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        [[self.snoozeView.dontRepeatButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.snoozeView.dontRepeatButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.repeatInterval = NSCalendarUnitHour;

    }
    else
    {
        self.repeatInterval = 0;
    }

}

- (void) clearAllSnoozeButton
{
    [[self.snoozeView.everyMinuteButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
    [self.snoozeView.everyMinuteButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
    
    [[self.snoozeView.dontRepeatButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
    [self.snoozeView.dontRepeatButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
    
    [[self.snoozeView.everyHourButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
    [self.snoozeView.everyHourButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
}

#pragma mark - Days button actions

- (void)dayButtonSelected:(UIButton *)sender
{
    if (sender == self.daysView.mondayButton)
    {
        if (self.mon)
        {
            [self deactivateDayButton:sender];
            self.mon = NO;
        }
        else
        {
            [self activateDaysButton:sender];
            self.mon = YES;
        }
    }
    
    else if (sender == self.daysView.tuesdayButton)
    {
        if (self.tue)
        {
            [self deactivateDayButton:sender];
            self.tue = NO;
        }
        else
        {
            [self activateDaysButton:sender];
            self.tue = YES;
        }
    }
    else if (sender == self.daysView.wednesdayButton)
    {
        if (self.wed)
        {
            [self deactivateDayButton:sender];
            self.wed = NO;
        }
        else
        {
            [self activateDaysButton:sender];
            self.wed = YES;
        }
    }
    
    else if (sender == self.daysView.thrusdayButton)
        {
         
            if (self.thu)
                {
                    [self deactivateDayButton:sender];
                    self.thu = NO;
                }
        
            else
                {
                    [self activateDaysButton:sender];
                    self.thu = YES;
                    
                }
            
        }
    if (sender == self.daysView.fridayButton)
    {
        if (self.fri)
        {
            [self deactivateDayButton:sender];
            self.fri = NO;
        }
        else
        {
            [self activateDaysButton:sender];
            self.fri = YES;
        }
    }
    if (sender == self.daysView.saturdayButton)
    {
        if (self.sat)
        {
            [self deactivateDayButton:sender];
            self.sat = NO;
        }
        else
        {
            [self activateDaysButton:sender];
            self.sat = YES;
        }
    }
    if (sender == self.daysView.sundayButton)
    {
        if (self.sun)
        {
            [self deactivateDayButton:sender];
            self.sun = NO;
        }
        else
        {
            [self activateDaysButton:sender];
            self.sun = YES;
        }
    }
}

- (void)createDays
{
    [self.daysArray removeAllObjects];
    
    if (self.mon)
    {
        [self.daysArray addObject:[NSNumber numberWithInt:1]];
    }
    if (self.tue)
    {
        [self.daysArray addObject:[NSNumber numberWithInteger:2]];
    }
    if(self.wed)
    {
        [self.daysArray addObject:[NSNumber numberWithInteger:3]];
    }
    if(self.thu)
    {
        [self.daysArray addObject:[NSNumber numberWithInteger:4]];
    }
    if (self.fri)
    {
        [self.daysArray addObject:[NSNumber numberWithInteger:5]];
    }
    if (self.sat)
    {
        [self.daysArray addObject:[NSNumber numberWithInteger:6]];
    }
    if (self.sun)
    {
        [self.daysArray addObject:[NSNumber numberWithInteger:7]];
    }
    if (self.mon && self.tue && self.wed && self.thu && self.fri && self.sat && self.sun)
    {
        [self.daysArray removeAllObjects];
        [self.daysArray addObject:[NSNumber numberWithInteger:8]];
    }
    if (!self.mon && !self.tue && !self.wed && !self.thu && !self.fri && !self.sat && !self.sun)
    {
        [self.daysArray removeAllObjects];
        [self.daysArray addObject:[NSNumber numberWithInteger:0]];
    }
   
}

- (void)deactivateAllDaysButton
{
    self.mon = YES;
    self.tue = YES;
    self.wed = YES;
    self.thu = YES;
    self.fri = YES;
    self.sat = YES;
    self.sun = YES;
    
    [self dayButtonSelected:self.daysView.mondayButton];
    [self dayButtonSelected:self.daysView.tuesdayButton];
    [self dayButtonSelected:self.daysView.wednesdayButton];
    [self dayButtonSelected:self.daysView.thrusdayButton];
    [self dayButtonSelected:self.daysView.fridayButton];
    [self dayButtonSelected:self.daysView.saturdayButton];
    [self dayButtonSelected:self.daysView.sundayButton];

}

- (void)activateDaysButton:(UIButton *)sender
{
    [[sender layer] setBorderWidth:2.0f];
    sender.layer.cornerRadius = 10;
    sender.clipsToBounds = YES;
    [[sender layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
    [sender setTitleColor:DAYS_BUTTON_ACTIVE_COLOR forState:UIControlStateNormal];
}

- (void)deactivateDayButton:(UIButton *)sender
{
    [[sender layer] setBorderColor:[UIColor whiteColor].CGColor];
    [sender setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
}

#pragma mark - Alarm tone button actions

/// Selecting alarm tone
- (void) alarmToneButtonSelected:(UIButton *)sender
{
    // selecting Default Tone button
    if (sender == self.AlarmToneview.alarmToneDefaultButton)
    {
        [[sender layer] setBorderWidth:2.0f];
        sender.layer.cornerRadius = 10;
        sender.clipsToBounds = YES;
        [[sender layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
        [sender setTitleColor:SNOOZE_BUTTON_SELECTION_COLOR forState:UIControlStateNormal];
        
        [[self.AlarmToneview.alarmTone1Button layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.AlarmToneview.alarmTone1Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        [[self.AlarmToneview.alarmTone2Button layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.AlarmToneview.alarmTone2Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.alarmTone = @"default";
    }
    
    //selecting alarm tone 1 Button
    else if (sender == self.AlarmToneview.alarmTone1Button)
    {
        [[sender layer] setBorderWidth:2.0f];
        sender.layer.cornerRadius = 10;
        sender.clipsToBounds = YES;
        [[sender layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
        [sender setTitleColor:SNOOZE_BUTTON_SELECTION_COLOR forState:UIControlStateNormal];
        
        [[self.AlarmToneview.alarmTone2Button layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.AlarmToneview.alarmTone2Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        [[self.AlarmToneview.alarmToneDefaultButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.AlarmToneview.alarmToneDefaultButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.alarmTone = @"alarmTone1.mp3";
        
        // Construct URL to sound file
        NSString *path = [NSString stringWithFormat:@"%@/drum01.mp3", [[NSBundle mainBundle] resourcePath]];
        NSURL *soundUrl = [NSURL fileURLWithPath:path];
        
        // Create audio player object and initialize with URL to sound
       // self.audio = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
        
       // [self.audio play];

    }
    
    //selecting alarm tone 2 button
    else if (sender == self.AlarmToneview.alarmTone2Button)
    {
        [[sender layer] setBorderWidth:2.0f];
        sender.layer.cornerRadius = 10;
        sender.clipsToBounds = YES;
        [[sender layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
        [sender setTitleColor:SNOOZE_BUTTON_SELECTION_COLOR forState:UIControlStateNormal];
        
        [[self.AlarmToneview.alarmToneDefaultButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.AlarmToneview.alarmToneDefaultButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        [[self.AlarmToneview.alarmTone1Button layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
        [self.AlarmToneview.alarmTone1Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.alarmTone = @"alarmTone2.mp3";
    }

}

- (void) clearAllAlarmToneButton
{
    [[self.AlarmToneview.alarmToneDefaultButton layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
    [self.AlarmToneview.alarmToneDefaultButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
    
    [[self.AlarmToneview.alarmTone1Button layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
    [self.AlarmToneview.alarmTone1Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
    
    [[self.AlarmToneview.alarmTone2Button layer] setBorderColor:(__bridge CGColorRef _Nullable)([UIColor whiteColor])];
    [self.AlarmToneview.alarmTone2Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
}

#pragma mark - textField Delegate methods

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    //Keyboard becomes visible
    scrollView.frame = CGRectMake(scrollView.frame.origin.x,
                                  scrollView.frame.origin.y,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height - 215 + 50);   //resize
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    //keyboard will hide
    scrollView.frame = CGRectMake(scrollView.frame.origin.x,
                                  scrollView.frame.origin.y,
                                  scrollView.frame.size.width,
                                  scrollView.frame.size.height + 215 - 50); //resize
}

@end
