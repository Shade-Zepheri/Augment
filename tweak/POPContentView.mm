#import "POPContentView.h"
#import "CDTContextHostProvider.h"

@implementation POPContentView
-(id)initWithFrame:(CGRect)frame contextHostView:(UIView*)contextHostView {
    if ((self = [super initWithFrame:frame])) {
        self.clipsToBounds = YES;

        _keyWindow = [[[NSClassFromString(@"SBIconController") sharedInstance] _rootFolderController] contentView];

        self.contextHostView = contextHostView;
        contextHostView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.70, 0.70);
        contextHostView.layer.cornerRadius = 10;
        contextHostView.layer.masksToBounds = YES;
        //the context host view slides up from the bottom of the screen
        contextHostView.center = CGPointMake(_keyWindow.center.x, _keyWindow.center.y);

        _dimView = [[_UIBackdropView alloc] initWithFrame:[[UIScreen mainScreen] bounds] autosizesToFitSuperview:NO settings:[NSClassFromString(@"_UIBackdropViewSettings") settingsForStyle:1]];
        _dimView.center = self.center;
        _dimView.alpha = 0.0;
        //don't allow them to interact with the HS while this is active
        _dimView.userInteractionEnabled = YES;

        [self addSubview:_dimView];
        [self addSubview:contextHostView];
    }
    return self;
}
-(void)fadeDimIn {
    [UIView animateWithDuration:0.75 animations:^{
        _dimView.alpha = 1.0;
    }];
}
@end
