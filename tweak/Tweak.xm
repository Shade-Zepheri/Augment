#import "Augment.h"
AppWindow *appWindow;
static CDTContextHostProvider *_contextHostProvider;
static NSMutableDictionary *_windows;
static NSInteger _stackedWindowLevel;
static NSString *bundleID = @"com.apple.MobileSMS";

%hook SpringBoard
	- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig();
	_stackedWindowLevel = 9999;
	_contextHostProvider = [[CDTContextHostProvider alloc] init];
	_windows = [[NSMutableDictionary alloc] init];
	//SBApplication *appToWindow = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];

	UIView *contextHost = [_contextHostProvider hostViewForApplicationWithBundleID:bundleID];

	appWindow = [[AppWindow alloc] initWithFrame:CGRectMake(87.5, 100, 200, 200)];

	[appWindow setIdentifier:bundleID];
	[appWindow setHostedContextView:contextHost];
	[appWindow setWindowLevel:_stackedWindowLevel++];
	[appWindow addSubview:contextHost];

	[_contextHostProvider setStatusBarHidden:@(1) onApplicationWithBundleID:bundleID];

	[_windows setValue:appWindow forKey:bundleID];

	[_contextHostProvider sendPortraitRotationNotificationToBundleID:bundleID];
}
%end

@implementation AugMent

+ (id)sharedInstance {
	static dispatch_once_t p = 0;
	__strong static id _sharedObject = nil;

	dispatch_once(&p, ^{
		_sharedObject = [[self alloc] init];
	});

	return _sharedObject;
}


@end
