//
//  AlarmEditTableViewController.h
//  Alarm
//
//  Created by Sunil Rao on 12/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NotifyDelegate <NSObject>

- (void)notifyBool:(BOOL)b withTitle:(NSString*)label;

@end

@class AlarmListTableViewController;

@interface AlarmEditTableViewController : UITableViewController<UINavigationBarDelegate,UITextFieldDelegate>

- (void) didEdit:(BOOL)edit index:(NSIndexPath*)index;
- (void)deactivateAllDaysButton;
- (void) clearAllAlarmToneButton;

@property (nonatomic,weak) id<NotifyDelegate>delegate;

@end
