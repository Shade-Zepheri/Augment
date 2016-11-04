#import "AugWindow.h"

@implementation AugWindow


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      self.windowLevel = UIWindowLevelAlert + 1.0;
      [self makeKeyAndVisible];
    }
    return self;
}

@end
