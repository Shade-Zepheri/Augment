#import "AugWindow.h"
#import "CDTContextHostProvider.h"
#import "Interfaces.h"
AugWindow* window;
UIView* appView;

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)arg1 {
  %orig();
	window = [[AugWindow alloc] initWithFrame:CGRectMake(37.5,67,300,533)];
	appView = [[CDTContextHostProvider sharedInstance] hostViewForApplicationWithBundleID:@"com.apple.MobileSMS"];
	[window addSubview:appView];
}
%end
