//
//  DesignSheet.h
//  Alarm
//
//  Created by Sunil Rao on 20/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#ifndef DesignSheet_h
#define DesignSheet_h

//FONTS
#define TITLE_FONT                          30
#define FONT_STYLE                          @"ChalkboardSE-Regular"
#define HEADER_TITLE_FONT                   15
#define NOTIFY_LABEL_FONT                   17
#define SNOOZE_BUTTON_TITLE_FONT            15
#define MESSAGE_LABEL_FONT                  25
#define SUBTITLE_LABEL_FONT                 14

//COLORS
#define HEADER_LABEL_TEXT_COLOR             [UIColor blueColor]
#define HEADER_LABEL_BACKGROUND_COLOR       RGBACOLOR(176, 196, 222, 0.30)
#define TABLECELL_BACKGROUND_COLOR          [UIColor whiteColor]
#define DELETE_BUTTON_COLOR_ACTIVE          [UIColor redColor]
#define DELETE_BUTTON_COLOR_DEACTIVE        [UIColor whiteColor]
#define BUTTON_BACKGROUND_COLOR             RGBACOLOR(176, 196, 222, 0.30)
#define RGBACOLOR(r,g,b,a)                  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define NOTIFY_LABEL_TEXT_COLOR             [UIColor blueColor]
#define SNOOZE_BUTTON_COLOR                 [UIColor lightGrayColor]
#define SNOOZE_BUTTON_SELECTION_COLOR       [UIColor blackColor]
#define DAYS_BUTTON_DEACTIVE_COLOR          [UIColor lightGrayColor]
#define DAYS_BUTTON_ACTIVE_COLOR            [UIColor blackColor]

//TITLE
#define CLOCK_HEADER_LABEL                  @"Clock"
#define SNOOZE_TIME_LABEL                   @"Snooze Time"
#define DAYS_LABEL                          @"Days"
#define ALERT_MESSAGE_LABEL                 @"Alert Message"
#define ALARM_TONE_LABEL                    @"Alarm Tone"
#define CREATE_BUTTON_TITLE                 @"Create"
#define UPDATE_BUTTON_TITLE                 @"Update"
#define DELETE_BUTTON_TITLE                 @"Delete"


#endif /* DesignSheet_h */
