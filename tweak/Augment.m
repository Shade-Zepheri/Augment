#import "Augment.h"

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
	HBLogDebug(@"%@", bundleID);
  SBApplication *appToWindow = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];
  UIView *contextHost = [_contextHostProvider hostViewForApplicationWithBundleID:bundleID];
	HBLogDebug(@"%@", appToWindow);
  AugWindow *appWindow = [[AugWindow alloc] initWithFrame:CGRectMake(37.5, 67, 300, 533)];

  [appWindow setIdentifier:bundleID];
  [appWindow setHostedContextView:contextHost];
  [appWindow setWindowLevel:_stackedWindowLevel++];

  if ([appToWindow respondsToSelector:@selector(statusBarHidden)]) {

     [appWindow setStatusBarHidden:[appToWindow statusBarHidden]];
  }

  [appWindow addSubview:contextHost];

  [_contextHostProvider setStatusBarHidden:@(1) onApplicationWithBundleID:bundleID];

  [_windows setValue:appWindow forKey:bundleID];

  [_contextHostProvider sendPortraitRotationNotificationToBundleID:bundleID];
}

- (void)unwindowApplicationWithBundleID:(NSString *)bundleID {

    //get window instance, if exists
    __block AugWindow *window;
    if ([_windows valueForKey:bundleID]) {

        window = [_windows valueForKey:bundleID];
    }

    else {

        //stop if it doesnt exist
        return;
    }

    //show statusbar
	[_contextHostProvider setStatusBarHidden:@([window statusBarHidden]) onApplicationWithBundleID:bundleID];

	//animate it out
	[UIView animateWithDuration:0.3 animations:^{

		//fade it out
		[window setAlpha:0];
		[window setTransform:CGAffineTransformMakeScale(.1, .1)];

	} completion:^(BOOL completed){

		//end hosting
		SBApplication *appToHost = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];
		[_contextHostProvider disableBackgroundingForApplication:appToHost];
		[_contextHostProvider stopHostingForBundleID:bundleID];

		//remove the view
		[window setHidden:YES];
        window = NULL;

        //remove value from dict
        [[(AugWindow *)[_windows valueForKey:bundleID] hostingCheckTimer] invalidate];
        [_windows removeObjectForKey:bundleID];

    }];

}

- (id)topmostApplication {
	return [[UIApplication sharedApplication] _accessibilityFrontMostApplication];
}

@end
