#import "Augment.h"
UIWindow* mainWindow;
CDTContextHostProvider *_contextHostProvider;

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig();
	_contextHostProvider = [[CDTContextHostProvider alloc] init];
	mainWindow = [[UIWindow alloc] initWithFrame:CGRectMake(100,100,175,467)];
	mainWindow.windowLevel = UIWindowLevelAlert + 1.0;
	[mainWindow makeKeyAndVisible];
	UIView *contextHost = [_contextHostProvider hostViewForApplicationWithBundleID:[[[UIApplication sharedApplication] _accessibilityFrontMostApplication] valueForKey:@"_bundleIdentifier"]];
	//[[CDTContextHostProvider sharedInstance] hostViewForApplicationWithBundleID:[[[UIApplication sharedApplication] _accessibilityFrontMostApplication] valueForKey:@"_bundleIdentifier"]];
	[mainWindow addSubview:contextHost];
}
%end
