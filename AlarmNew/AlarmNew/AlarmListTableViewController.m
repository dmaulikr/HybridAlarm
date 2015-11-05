//
//  AlarmListTableViewController.m
//  Alarm
//
//  Created by Sunil Rao on 12/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#import "AlarmListTableViewController.h"
#import "AlarmDataSource.h"
#import "AlarmItem.h"
#import "NotificationLabelView.h"
#import "AlarmListTableViewCell.h"

@interface AlarmListTableViewController ()

@property (nonatomic,strong) sharedInstance *dataSource;
@property (nonatomic,strong) AlarmEditTableViewController *aevc;
@property (nonatomic,strong) NotificationLabelView *notify;
@property (nonatomic,assign) BOOL isNotify;
@property (nonatomic,strong) NSString *notifyLabel;
@property (nonatomic,strong) AlarmListTableViewCell *tableCellView;
@property (nonatomic,strong) NSString *daysText;

@end

@implementation AlarmListTableViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        //creating add alarm button
        UINavigationItem *navI = self.navigationItem;
        navI.title = @"Alarm";
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAlarm)];
        
        //Initialization
        self.aevc = [[AlarmEditTableViewController alloc]init];
        self.aevc.delegate = self;
        self.dataSource = [sharedInstance sharedInstance];
        self.isNotify = NO;
        self.notifyLabel = NULL;
        self.tableCellView = [[AlarmListTableViewCell alloc]init];
        
        //Creating edit button
        navI.leftBarButtonItem = self.editButtonItem;
        navI.rightBarButtonItem = addButton;
        
        self.tableView.bounces = NO;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    self.editing = NO;
    //Check to display Alarm event created notification
    if (self.isNotify)
    {
        //Initializing notification label
        self.notify = [[NotificationLabelView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * 0.05,SCREEN_HEIGHT * 0.70, SCREEN_WIDTH * 0.90, SCREEN_HEIGHT * 0.10)];
        self.notify.notifyLabel.text = self.notifyLabel;
        [self.view addSubview:self.notify];
        self.notify.alpha = 0;
        [self animateLabel];
    }
    
    //Rearranging tabel cell based on chronological order
    
}
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    return self;

}
- (void) addAlarm
{
    //adding new alarm event
    self.aevc = [[AlarmEditTableViewController alloc]init];
    self.aevc.delegate = self;
    [self.aevc didEdit:NO index:nil];
    [self.aevc deactivateAllDaysButton];
    [self.aevc clearAllAlarmToneButton];
    [self.navigationController pushViewController:self.aevc animated:YES];
}

- (void)animateLabel
{
    
    [UIView animateKeyframesWithDuration:1
                                   delay:0
                                 options:0
                              animations:^{
                                  
                                  self.notify.alpha = 1;
                              }
                              completion:^(BOOL finished) {
                                  [UIView animateKeyframesWithDuration:1
                                                                 delay:1
                                                               options:0
                                                            animations:^{
                                                                
                                                                self.notify.alpha = 0;
                                                            }
                                                            completion:^(BOOL finished) {
                                                                self.isNotify = NO;
                                                                [self.notify removeFromSuperview];
                                                                self.notify = nil;
                                                            }];
                              }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataSource allEvents] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //To update existing alarm event
//    self.aevc = [[AlarmEditTableViewController alloc]init];
    [self.aevc didEdit:YES index:indexPath];
    [self.navigationController pushViewController:self.aevc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray *allEvents = [self.dataSource allEvents];
    AlarmItem *item = [[AlarmItem alloc]init];
    item = [allEvents objectAtIndex:indexPath.row];
    self.tableCellView = [[AlarmListTableViewCell alloc]init];
    self.tableCellView.messageLabel.text = item.customLabel;
    self.tableCellView.subtitleLabel.text = [self stringForDate:item.time withDays:item.days];
    self.tableCellView.toggleButton.on = item.activate;
    cell = self.tableCellView;
    self.tableCellView.toggleButton.tag = indexPath.row;
    
    [self.tableCellView.toggleButton addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventValueChanged];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_HEIGHT * 0.10;
}
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSArray *items = [self.dataSource allEvents];
        AlarmItem *i = [items objectAtIndex:indexPath.row];
        [self.dataSource removeItem:i];
        [self.tableView reloadData];
    }
}

/// Conversion of Date to String
- (NSString *) stringForDate:(NSDate *)date withDays:(NSMutableArray *)daysArray
{
    // Creating Time format with AM/PM
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    //setting the date format style as Time Style.
    [dateFormat setTimeStyle:NSDateFormatterFullStyle];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];

    self.daysText = [[NSString alloc]init];
    NSArray *daysA = [daysArray copy];
    for (NSNumber *day in daysA)
    {
        switch ([day intValue])
        {
            case 0:
                self.daysText = @" never";
                break;
                
            case 1:
                self.daysText = @" Mon";
                break;
            
            case 2:
                self.daysText = [self.daysText stringByAppendingString:@" Tue"];
                break;
                
            case 3:
                self.daysText = [self.daysText stringByAppendingString:@" Wed"];
                break;
                
            case 4:
                self.daysText = [self.daysText stringByAppendingString:@" Thu"];
                break;
                
            case 5:
                self.daysText = [self.daysText stringByAppendingString:@" Fri"];
                break;
                
            case 6:
                self.daysText = [self.daysText stringByAppendingString:@" Sat"];
                break;
                
            case 7:
                self.daysText = [self.daysText stringByAppendingString:@" Sun"];
                break;
                
            case 8:
                self.daysText = @" every day";
                break;
                
            default:
                break;
        }
    }
    
    
    
    
    [dateFormat setDateFormat:@"MMM dd, hh:mm aa"];
    return [NSString stringWithFormat:@"%@   Repeat:%@",[dateFormat stringFromDate:date],self.daysText];
}

/// Delegate method to set notificaiton
- (void)notifyBool:(BOOL)b withTitle:(NSString*)label
{
    self.isNotify = b;
    self.notifyLabel = label;
}

- (void) toggle:(UISwitch *)button
{
    if (!button.on)
    {
        NSArray *data = [self.dataSource allEvents];
        AlarmItem *item = [data objectAtIndex:button.tag];
        item.activate = NO;
        [[UIApplication sharedApplication]cancelLocalNotification:item.notification];
    }
    else
    {
        NSArray *data = [self.dataSource allEvents];
        AlarmItem *item = [data objectAtIndex:button.tag];
        item.activate = YES;
        [[UIApplication sharedApplication] scheduleLocalNotification:item.notification];
    }
}

@end
