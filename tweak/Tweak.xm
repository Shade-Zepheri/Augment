#import "Augment.h"
#import "AppWindow.h"
#import "CDTContextHostProvider.h"
static CDTContextHostProvider *_contextHostProvider;
static NSInteger _stackedWindowLevel = 9999;
static NSString *bundleID = @"com.apple.Preferences";
static NSMutableDictionary *_windows = [[NSMutableDictionary alloc] init];

%hook SpringBoard
	- (void)applicationDidFinishLaunching:(id)arg1 {
		%orig();
		//SBApplication *appToWindow = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];

		UIView *contextHost = [_contextHostProvider hostViewForApplicationWithBundleID:@"com.apple.MobileSMS"];

		AppWindow *appWindow = [[AppWindow alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];

		[appWindow setIdentifier:@"com.apple.MobileSMS"];
		[appWindow setHostedContextView:contextHost];
		appWindow.windowLevel = UIWindowLevelAlert + 1.0;
		[appWindow addSubview:contextHost];
		[_contextHostProvider setStatusBarHidden:@(1) onApplicationWithBundleID:@"com.apple.MobileSMS"];
		[_windows setValue:appWindow forKey:@"com.apple.MobileSMS"];
		[_contextHostProvider sendPortraitRotationNotificationToBundleID:@"com.apple.MobileSMS"];
		[appWindow makeKeyAndVisible];
	}
%end
