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
        [self addSubview:contextHostView];
    }
    return self;
}
@end
