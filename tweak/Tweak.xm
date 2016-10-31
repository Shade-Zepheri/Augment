#import "Augment.h"

%hook SpringBoard
	- (void)applicationDidFinishLaunching:(id)arg1 {
		%orig();
	}
%end
