/*

Credits to CortexDevTeam and Ethan Arbuckle for the method

*/
#import "AppWindow.h"

@implementation AppWindow

- (float)level{
    return 99999;
}

- (id)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self makeKeyAndVisible];
        _contextProvider = [[CDTContextHostProvider alloc] init];
        _hostingCheckTimer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(runHostCheck) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_hostingCheckTimer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)runHostCheck {
    if (_hostedContextView && ![_contextProvider isHostViewHosting:_hostedContextView] && [self superview]) {
        [_hostedContextView removeFromSuperview];
        CGRect frame = [_hostedContextView frame];
        _hostedContextView = [_contextProvider hostViewForApplicationWithBundleID:_identifier];
        [_hostedContextView setFrame:frame];
        [self addSubview:_hostedContextView];
    }
}

@end
