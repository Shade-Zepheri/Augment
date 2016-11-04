#import <UIKit/UIKit.h>
#import "CDTContextHostProvider.h"

@interface AugWindow : UIWindow

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) UIView *hostedContextView;
@property (nonatomic, retain) NSTimer *hostingCheckTimer;
@property (nonatomic, retain) CDTContextHostProvider *contextProvider;

@property UIInterfaceOrientation *activeOrientation;
@property BOOL statusBarHidden;

- (float)level;
- (void)runHostingCheck;

@end
