#import "CDTContextHostProvider.h"
#import "Augment.h"
UIView* contextHostView;

%hook SpringBoard
	- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig();
	contextHostView = [[CDTContextHostProvider sharedInstance] hostViewForApplicationWithBundleID:@"com.apple.MobileSMS"];
}
%end
