#import "Augment.h"
#import "Interfaces.h"

%hook SpringBoard

- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig();
	[[AugMent sharedInstance] beginWindowModeForApplicationWithBundleID:@"com.jormy.journ"];
}

%end
