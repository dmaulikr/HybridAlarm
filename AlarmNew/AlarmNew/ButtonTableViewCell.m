//
//  ButtonTableViewCell.m
//  Alarm
//
//  Created by Sunil Rao on 16/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "ButtonTableViewCell.h"

@implementation ButtonTableViewCell

- (instancetype)init
{
    self = [super init];
    {
        self.backgroundColor = TABLECELL_BACKGROUND_COLOR;
        
        //creating add button
        self.addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.addButton setTitle:CREATE_BUTTON_TITLE forState:UIControlStateNormal];
        [self addBorder:self.addButton];
        [self.contentView addSubview:self.addButton];
        
        //creating update button
        self.updateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.updateButton setTitle:UPDATE_BUTTON_TITLE forState:UIControlStateNormal];
        [self addBorder:self.updateButton];
        [self.contentView addSubview:self.updateButton];
        
        //creating cancel button
        self.cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.cancelButton setTitle:DELETE_BUTTON_TITLE forState:UIControlStateNormal];
        [self addBorder:self.cancelButton];
        [self.contentView addSubview:self.cancelButton];
        
    }
    
    return self;
}

/// Adding curved border to the button
-(void)addBorder:(UIButton *)button
{
    [button.titleLabel setFont:[UIFont fontWithName:FONT_STYLE size:HEADER_TITLE_FONT]];
    [[button layer] setBorderWidth:2.0f];
    button.layer.cornerRadius = 10; // this value vary as per your desire
    button.clipsToBounds = YES;
    [[button layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];
    button.backgroundColor = BUTTON_BACKGROUND_COLOR;
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.cancelButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.10, TABLECELL_HEIGHT * 0.10, TABLECELL_WIDTH * 0.30, TABLECELL_HEIGHT * 0.60)];
    self.cancelButton.center = CGPointMake(TABLECELL_WIDTH * 0.25, TABLECELL_HEIGHT * 0.50);
    
    [self.addButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.60, TABLECELL_HEIGHT * 0.10, TABLECELL_WIDTH * 0.30, TABLECELL_HEIGHT * 0.60)];
    self.addButton.center = CGPointMake(TABLECELL_WIDTH * 0.75, TABLECELL_HEIGHT * 0.50);
    
    [self.updateButton setFrame:CGRectMake(TABLECELL_WIDTH * 0.60, TABLECELL_HEIGHT * 0.10, TABLECELL_WIDTH * 0.30, TABLECELL_HEIGHT * 0.60)];
    self.updateButton.center = CGPointMake(TABLECELL_WIDTH * 0.75, TABLECELL_HEIGHT * 0.50);

}
@end
