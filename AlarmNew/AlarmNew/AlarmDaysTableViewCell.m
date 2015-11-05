//
//  AlarmDaysButtonView.m
//  Alarm
//
//  Created by Sunil Rao on 19/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmDaysTableViewCell.h"

@interface AlarmDaysTableViewCell()

@property (nonatomic,strong) UILabel *header;

@end

@implementation AlarmDaysTableViewCell
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = TABLECELL_BACKGROUND_COLOR;
        
        //Adding weekDay buttons
        
        self.mondayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.mondayButton setTitle:@"Mon" forState:UIControlStateNormal];
        [self.mondayButton setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:self.mondayButton];
        
        self.tuesdayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.tuesdayButton setTitle:@"Tue" forState:UIControlStateNormal];
        [self.tuesdayButton setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:self.tuesdayButton];
        
        self.wednesdayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.wednesdayButton setTitle:@"Wed" forState:UIControlStateNormal];
        [self.wednesdayButton setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:self.wednesdayButton];
        
        self.thrusdayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.thrusdayButton setTitle:@"Thu" forState:UIControlStateNormal];
        [self.thrusdayButton setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:self.thrusdayButton];
        
        self.fridayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.fridayButton setTitle:@"Fri" forState:UIControlStateNormal];
        [self.fridayButton setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:self.fridayButton];
        
        self.saturdayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.saturdayButton setTitle:@"Sat" forState:UIControlStateNormal];
        [self.saturdayButton setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:self.saturdayButton];
        
        self.sundayButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.sundayButton setTitle:@"Sun" forState:UIControlStateNormal];
        [self.sundayButton setTitleColor:DAYS_BUTTON_DEACTIVE_COLOR forState:UIControlStateNormal];
        [self.contentView addSubview:self.sundayButton];
        
        //Creating header
        self.header = [[UILabel alloc]init];
        self.header.text = DAYS_LABEL;
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
    
    [self.mondayButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.10, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.10, TABLECELL_HEIGHT * 0.60)];
    
    [self.tuesdayButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.21, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.09, TABLECELL_HEIGHT * 0.60)];
    
    [self.wednesdayButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.32, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.10, TABLECELL_HEIGHT * 0.60)];

    [self.thrusdayButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.43, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.09, TABLECELL_HEIGHT * 0.60)];

    [self.fridayButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.54, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.09, TABLECELL_HEIGHT * 0.60)];

    [self.saturdayButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.65, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.09, TABLECELL_HEIGHT * 0.60)];
    
    [self.sundayButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.76, TABLECELL_HEIGHT * 0.30, TABLECELL_WIDTH * 0.09, TABLECELL_HEIGHT * 0.60)];
    
    self.header.frame = TABLECELL_DEFAULT_HEADER_FRAME;
    
}

@end
