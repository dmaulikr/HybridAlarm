//
//  AlarmClockTableViewCell.m
//  Alarm
//
//  Created by Sunil Rao on 16/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmClockTableViewCell.h"


@interface AlarmClockTableViewCell()

@property (nonatomic,strong) UILabel *header;

@end

@implementation AlarmClockTableViewCell

- (instancetype) init
{
    self = [super init];
    
    if(self)
    {
        self.backgroundColor = TABLECELL_BACKGROUND_COLOR;
        
        // Creating Date Picker
        self.datePicker = [[UIDatePicker alloc]init];
        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        self.datePicker.timeZone = [NSTimeZone systemTimeZone];
        self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
        [self.contentView addSubview:self.datePicker];
        
        //Creating header
        self.header = [[UILabel alloc]init];
        self.header.text = CLOCK_HEADER_LABEL;
        [self.header setFont:[UIFont fontWithName:FONT_STYLE size:HEADER_TITLE_FONT]];
        self.header.textColor = HEADER_LABEL_TEXT_COLOR;
        self.header.backgroundColor = HEADER_LABEL_BACKGROUND_COLOR;
        self.header.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:self.header];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.datePicker setFrame:CGRectMake(TABLECELL_ORIGIN_X, TABLECELL_ORIGIN_Y - TABLECELL_ORIGIN_Y * 0.2, TABLECELL_WIDTH, TABLECELL_HEIGHT)];
    
    self.header.frame = TABLECELL_ALARM_HEADER_FRAME;
}

@end
