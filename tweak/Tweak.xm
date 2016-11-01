#import "Augment.h"
AppWindow *appWindow;

%hook SpringBoard
	- (void)applicationDidFinishLaunching:(id)arg1 {
	%orig();
	[[AugMent sharedInstance] beginWindowModeForTopApplication];
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

- (id)init {
	if (self = [super init]) {
    _stackedWindowLevel = 9999;
		_contextHostProvider = [[CDTContextHostProvider alloc] init];
    _windows = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void)beginWindowModeForTopApplication {
  NSString *bundleID = [[self topmostApplication] valueForKey:@"_bundleIdentifier"];
  [self beginWindowModeForApplicationWithBundleID:bundleID];
}

- (void)beginWindowModeForApplicationWithBundleID:(NSString *)bundleID {
	//SBApplication *appToWindow = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];
	UIView *contextHost = [_contextHostProvider hostViewForApplicationWithBundleID:bundleID];

	appWindow = [[AppWindow alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];

	[appWindow setIdentifier:bundleID];
	[appWindow setHostedContextView:contextHost];
	[appWindow setWindowLevel:_stackedWindowLevel++];

	[appWindow addSubview:contextHost];

	[_contextHostProvider setStatusBarHidden:@(1) onApplicationWithBundleID:bundleID];

	[_windows setValue:appWindow forKey:bundleID];

	[_contextHostProvider sendPortraitRotationNotificationToBundleID:bundleID];
}

- (id)topmostApplication {
	return [[UIApplication sharedApplication] _accessibilityFrontMostApplication];
}


@end
