



#import "NotificationLabelView.h"

@implementation NotificationLabelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.notifyLabel = [[UILabel alloc]init];
        self.notifyLabel.backgroundColor = HEADER_LABEL_BACKGROUND_COLOR;
        [self.notifyLabel setFont:[UIFont fontWithName:FONT_STYLE size:NOTIFY_LABEL_FONT]];
        self.notifyLabel.textAlignment = NSTextAlignmentCenter;
        [self.notifyLabel setTextColor:NOTIFY_LABEL_TEXT_COLOR];
        [[self.notifyLabel layer] setBorderWidth:2.0f];
        self.notifyLabel.layer.cornerRadius = 10; // this value vary as per your desire
        self.notifyLabel.clipsToBounds = YES;
        [[self.notifyLabel layer] setBorderColor:HEADER_LABEL_BACKGROUND_COLOR.CGColor];

        [self.notifyLabel sizeToFit];
        [self addSubview:self.notifyLabel];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.notifyLabel.frame = self.frame;
    self.notifyLabel.center = CGPointMake(self.frame.size.width * 0.50, self.frame.size.height * 0.40);

}
@end
