//
//  CustomLabelView.m
//  Alarm
//
//  Created by Sunil Rao on 19/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "CustomAlertMessageTableViewCell.h"

@interface CustomAlertMessageTableViewCell()
@end
@implementation CustomAlertMessageTableViewCell
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = TABLECELL_BACKGROUND_COLOR;
        
        // Creating custom message textfield
        self.customMessageTextField = [[UITextField alloc] init];
        self.customMessageTextField.placeholder = @"Enter alert message";
        self.customMessageTextField.keyboardType = UIKeyboardTypeDefault;
        self.customMessageTextField.returnKeyType = UIReturnKeyDone;
        
        //To display the cusor position text.
        self.customMessageTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        [self.contentView addSubview:self.customMessageTextField];

        //Creating header
        self.header = [[UILabel alloc]init];
        self.header.text = ALERT_MESSAGE_LABEL;
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
    
     [self.customMessageTextField setFrame:CGRectMake(TABLECELL_WIDTH * 0.05, TABLECELL_HEIGHT * 0.25, TABLECELL_WIDTH - (TABLECELL_WIDTH * 0.10) , TABLECELL_HEIGHT - TABLECELL_HEIGHT * 0.30)];
    self.header.frame = TABLECELL_DEFAULT_HEADER_FRAME;
}

@end
