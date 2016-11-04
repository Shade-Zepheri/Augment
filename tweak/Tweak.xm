#import "Augment.h"
#import "Interfaces.h"
UIWindow* window;

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig();
	[[AugMent sharedInstance] beginWindowModeForTopApplication];
}

%end
