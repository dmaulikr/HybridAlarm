//
//  AlarmListTableViewCell.m
//  AlarmNew
//
//  Created by Sunil Rao on 28/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmListTableViewCell.h"

@implementation AlarmListTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        // Creating Message Label
        self.messageLabel = [[UILabel alloc]init];
        self.messageLabel.textAlignment = NSTextAlignmentLeft;
        [self.messageLabel setFont:[UIFont fontWithName:FONT_STYLE size:MESSAGE_LABEL_FONT]];
        [self.contentView addSubview:self.messageLabel];
        
        // Creating Subtitle Label
        self.subtitleLabel = [[UILabel alloc]init];
        self.subtitleLabel.textAlignment = NSTextAlignmentLeft;
        [self.subtitleLabel setFont:[UIFont fontWithName:FONT_STYLE size:SUBTITLE_LABEL_FONT]];
        [self.contentView addSubview:self.subtitleLabel];
        
        // Creating toggle button
        self.toggleButton = [[UISwitch alloc]init];
        self.toggleButton.onTintColor = [UIColor greenColor];
        self.toggleButton.tintColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.toggleButton];
    }
    
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.messageLabel setFrame:CGRectMake(TABLECELL_WIDTH * 0.04, 0, TABLECELL_WIDTH * 0.80, TABLECELL_HEIGHT * 0.60)];
    
    [self.subtitleLabel setFrame:CGRectMake(TABLECELL_WIDTH * 0.04, TABLECELL_HEIGHT * 0.65, TABLECELL_WIDTH * 0.95, TABLECELL_HEIGHT * 0.30)];
    
    [self.toggleButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.80, TABLECELL_HEIGHT * 0.17, TABLECELL_WIDTH * 0.12, TABLECELL_HEIGHT * 0.65)];
    //self.toggleButton.center = CGPointMake(TABLECELL_WIDTH * 0.91, TABLECELL_HEIGHT * 0.50);
    
}
@end
