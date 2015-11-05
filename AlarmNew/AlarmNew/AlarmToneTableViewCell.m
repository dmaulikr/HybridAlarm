//
//  AlarmToneView.m
//  Alarm
//
//  Created by Sunil Rao on 20/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmToneTableViewCell.h"

@interface AlarmToneTableViewCell()

@property (nonatomic,retain) UILabel *header;

@end

@implementation AlarmToneTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = TABLECELL_BACKGROUND_COLOR;
        
        //Adding alarm tone default button
        self.alarmToneDefaultButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.alarmToneDefaultButton setTitle:@"Default\nTone" forState:UIControlStateNormal];
        [self.alarmToneDefaultButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.alarmToneDefaultButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.alarmToneDefaultButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.alarmToneDefaultButton];
        
        //Adding every minute button
        self.alarmTone1Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.alarmTone1Button setTitle:@"Alarm\nTone-1" forState:UIControlStateNormal];
        [self.alarmTone1Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.alarmTone1Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.alarmTone1Button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.alarmTone1Button];
        
        //Adding every hour button
        self.alarmTone2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.alarmTone2Button setTitle:@"Alarm\nTone-2" forState:UIControlStateNormal];
        [self.alarmTone2Button setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.alarmTone2Button.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.alarmTone2Button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.alarmTone2Button];

        //Creating header
        self.header = [[UILabel alloc]init];
        self.header.text = ALARM_TONE_LABEL;
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
    
    [self.alarmToneDefaultButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.10, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.20 , TABLECELL_HEIGHT * 0.60)];
    
    [self.alarmTone1Button setFrame:CGRectMake(TABLECELL_WIDTH * 0.40, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.20, TABLECELL_HEIGHT * 0.60)];
    
    [self.alarmTone2Button setFrame:CGRectMake(TABLECELL_WIDTH * 0.70, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.20, TABLECELL_HEIGHT * 0.60)];
    
    self.header.frame = TABLECELL_DEFAULT_HEADER_FRAME;
}

@end
