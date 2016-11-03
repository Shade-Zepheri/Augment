#import "AppView.h"
#import "CDTContextHostProvider.h"

@implementation AppView
- (id)initWithFrame:(CGRect)frame contextHostView:(UIView*)contextHostView {
    self = [super initWithFrame:frame];
    if (self) {
      self.clipsToBounds = YES;
      _keyWindow = [[[NSClassFromString(@"SBIconController") sharedInstance] _rootFolderController] contentView];

      self.contextHostView = contextHostView;
      contextHostView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.70, 0.70);
      contextHostView.layer.cornerRadius = 10;
      contextHostView.layer.masksToBounds = YES;
      [self addSubview:contextHostView];
    }
    return self;
}

@end
