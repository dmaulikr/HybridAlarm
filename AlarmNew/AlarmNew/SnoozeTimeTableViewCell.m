//
//  SnoozeTimeView.m
//  Alarm
//
//  Created by Sunil Rao on 19/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "SnoozeTimeTableViewCell.h"

@interface SnoozeTimeTableViewCell()

@property (nonatomic,strong) UILabel *header;

@end

@implementation SnoozeTimeTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = TABLECELL_BACKGROUND_COLOR;
        
        //Adding every second button
        self.dontRepeatButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.dontRepeatButton setTitle:@"Don't\nRepeat" forState:UIControlStateNormal];
        [self.dontRepeatButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.dontRepeatButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.dontRepeatButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.dontRepeatButton];

        //Adding every minute button
        self.everyMinuteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.everyMinuteButton setTitle:@"Every\nMinute" forState:UIControlStateNormal];
        [self.everyMinuteButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.everyMinuteButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.everyMinuteButton.titleLabel.textAlignment = NSTextAlignmentCenter;

        [self.contentView addSubview:self.everyMinuteButton];

        //Adding every hour button
        self.everyHourButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.everyHourButton setTitle:@"Every\nHour" forState:UIControlStateNormal];
        [self.everyHourButton setTitleColor:SNOOZE_BUTTON_COLOR forState:UIControlStateNormal];
        self.everyHourButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        self.everyHourButton.titleLabel.textAlignment = NSTextAlignmentCenter;

        [self.contentView addSubview:self.everyHourButton];

        //Creating header
        self.header = [[UILabel alloc]init];
        self.header.text = SNOOZE_TIME_LABEL;
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

    [self.dontRepeatButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.10, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.20 , TABLECELL_HEIGHT * 0.60)];

    [self.everyMinuteButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.40, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.20, TABLECELL_HEIGHT * 0.60)];

    [self.everyHourButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.70, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.20, TABLECELL_HEIGHT * 0.60)];
    
    
    self.header.frame = TABLECELL_DEFAULT_HEADER_FRAME;

}

@end
