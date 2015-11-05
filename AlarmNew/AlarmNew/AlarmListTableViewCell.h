//
//  AlarmListTableViewCell.h
//  AlarmNew
//
//  Created by Sunil Rao on 28/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmListTableViewCell : UITableViewCell

@property (nonatomic,strong) UILabel *messageLabel;
@property (nonatomic,strong) UILabel *subtitleLabel;
@property (nonatomic,strong) UISwitch *toggleButton;

@end
