/*

Credits to CortexDevTeam and Ethan Arbuckle for the method

*/
#import <UIKit/UIKit.h>
#import "CDTContextHostProvider.h"

@interface AppWindow : UIWindow

@property (nonatomic, retain) NSString *identifier;
@property (nonatomic, retain) UIView *hostedContextView;
@property (nonatomic, retain) NSTimer *hostingCheckTimer;
@property (nonatomic, retain) CDTContextHostProvider *contextProvider;
@property UIInterfaceOrientation *activeOrientation;

- (float)level;
- (void)runHostCheck;

@end
