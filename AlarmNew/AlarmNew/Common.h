//
//  CommonHeaders.h
//  Alarm
//
//  Created by Sunil Rao on 16/10/15.
//  Copyright © 2015 Razorthink. All rights reserved.
//

#ifndef Common_h
#define Common_h

#import <QuartzCore/QuartzCore.h>

/// Screen Dimensions
#define SCREEN_ORIGIN_X         [UIScreen mainScreen].bounds.origin.x
#define SCREEN_ORIGIN_Y         [UIScreen mainScreen].bounds.origin.y
#define SCREEN_HEIGHT           [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH            [UIScreen mainScreen].bounds.size.width

///TableCell Dimensions
#define TABLECELL_ORIGIN_X      self.frame.origin.x
#define TABLECELL_ORIGIN_Y      self.frame.origin.y
#define TABLECELL_WIDTH         self.frame.size.width
#define TABLECELL_HEIGHT        self.frame.size.height

// TABLE CELL HEADER DIMENSIONS
#define TABLECELL_ALARM_HEADER_FRAME        CGRectMake(TABLECELL_WIDTH - (TABLECELL_WIDTH * 0.97),0, TABLECELL_WIDTH - (TABLECELL_WIDTH * 0.06), TABLECELL_HEIGHT * 0.10)
#define TABLECELL_DEFAULT_HEADER_FRAME      CGRectMake(TABLECELL_WIDTH - (TABLECELL_WIDTH * 0.97),0, TABLECELL_WIDTH - (TABLECELL_WIDTH * 0.06), TABLECELL_HEIGHT * 0.25)

#endif /* CommonHeaders_h */
