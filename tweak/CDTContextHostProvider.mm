#import "CDTContextHostProvider.h"

@implementation CDTContextHostProvider

+ (instancetype)sharedInstance {
	// Setup instance for current class once
    static id sharedInstance = nil;
    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        sharedInstance = [self new];
    });
    // Provide instance
    return sharedInstance;
}

- (id)init {
	if ((self = [super init])) {
		_hostedApplications = [[NSMutableDictionary alloc] init];
		_currentAppHasFinishedLaunching = NO;
	}
	return self;
}

- (UIView *)hostViewForApplication:(SBApplication*)sbapplication {
	NSString* bundleIdentifier = sbapplication.bundleIdentifier;
  [self launchSuspendedApplicationWithBundleID:[(SBApplication *)sbapplication bundleIdentifier]];

	if ([_hostedApplications objectForKey:bundleIdentifier]) {
		return [_hostedApplications objectForKey:bundleIdentifier];
	}

	//let the app run in the background
	[self enableBackgroundingForApplication:sbapplication];

	//allow hosting of our new hostview
	[[self contextManagerForApplication:sbapplication] enableHostingForRequester:[(SBApplication *)sbapplication bundleIdentifier] orderFront:YES];

	//get our fancy new hosting view
	UIView *hostView = [[self contextManagerForApplication:sbapplication] hostViewForRequester:[(SBApplication *)sbapplication bundleIdentifier] enableAndOrderFront:YES];
		hostView.accessibilityHint = bundleIdentifier;

	return hostView;
}
/*
- (void)retrieveHostView:(UIView**)hostView application:(SBApplication*)sbapplication completion:(void(^)(void))completion {
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.05 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
		UIView *realHostView = [[self contextManagerForApplication:sbapplication] hostViewForRequester:[(SBApplication *)sbapplication bundleIdentifier] enableAndOrderFront:YES];
		if (realHostView) {
			*hostView = realHostView;
			completion();
		}
		else {
			[self retrieveHostView:*hostView application:sbapplication completion:completion];
		}
	});
}
*/
- (NSString*)bundleIDFromHostView:(UIView*)hostView {
	return hostView.accessibilityHint;
}

- (UIView *)hostViewForApplicationWithBundleID:(NSString *)bundleID {

	//get application reference
	SBApplication *appToHost = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];

	//return hostview
	return [self hostViewForApplication:appToHost];
}

- (void)launchSuspendedApplicationWithBundleID:(NSString *)bundleID {
	[[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:YES];
}

- (void)disableBackgroundingForApplication:(id)sbapplication {

	//get scene settings
	FBSMutableSceneSettings *sceneSettings = [self sceneSettingsForApplication:sbapplication];

	//force backgrounding to YES
	[sceneSettings setBackgrounded:YES];

	//reapply new settings to scene
	[[self FBSceneForApplication:sbapplication] _applyMutableSettings:sceneSettings withTransitionContext:nil completion:nil];

}

- (void)enableBackgroundingForApplication:(id)sbapplication {

	//get scene settings
	FBSMutableSceneSettings *sceneSettings = [self sceneSettingsForApplication:sbapplication];

	//force backgrounding to NO
	[sceneSettings setBackgrounded:NO];

	//reapply new settings to scene
	[[self FBSceneForApplication:sbapplication] _applyMutableSettings:sceneSettings withTransitionContext:nil completion:nil];

}

- (FBScene *)FBSceneForApplication:(id)sbapplication {
	return [(SBApplication *)sbapplication mainScene];
}

- (FBWindowContextHostManager *)contextManagerForApplication:(id)sbapplication {
	return [[self FBSceneForApplication:sbapplication] contextHostManager];
}

- (FBSMutableSceneSettings *)sceneSettingsForApplication:(id)sbapplication {
	return [[[self FBSceneForApplication:sbapplication] mutableSettings] mutableCopy];
}

- (BOOL)isHostViewHosting:(UIView *)hostView {
    if (hostView && [[hostView subviews] count] >= 1)
        return [(FBWindowContextHostView *)[hostView subviews][0] isHosting];
    return NO;
}

- (void)forceRehostingOnBundleID:(NSString *)bundleID {

    SBApplication *appToForce = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];
    [self launchSuspendedApplicationWithBundleID:bundleID];
    [self enableBackgroundingForApplication:appToForce];
    FBSceneHostManager *manager = [self contextManagerForApplication:appToForce];
    [manager enableHostingForRequester:bundleID priority:1];
}

- (void)stopHostingForBundleID:(NSString *)bundleID {

	SBApplication *appToHost = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];
	FBSceneHostManager *contextManager = [self contextManagerForApplication:appToHost];
	[contextManager disableHostingForRequester:bundleID];
    [self disableBackgroundingForApplication:appToHost];

    [_hostedApplications removeObjectForKey:bundleID];
}

- (void)sendLandscapeRotationNotificationToBundleID:(NSString *)bundleID {

	//notification is "identifierLamoRotate"
	NSString *rotateNotification = [NSString stringWithFormat:@"%@LamoLandscapeRotate", bundleID];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)rotateNotification, NULL, NULL, YES);
}

- (void)sendPortraitRotationNotificationToBundleID:(NSString *)bundleID {

	//notification is "identifierLamoRotate"
	NSString *rotateNotification = [NSString stringWithFormat:@"%@LamoPortraitRotate", bundleID];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)rotateNotification, NULL, NULL, YES);
}

- (void)setStatusBarHidden:(NSNumber *)hidden onApplicationWithBundleID:(NSString *)bundleID {


    NSString *changeStatusBarNotification = [NSString stringWithFormat:@"%@LamoStatusBarChange", bundleID];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)changeStatusBarNotification, NULL, (__bridge CFDictionaryRef) @{@"isHidden" : hidden } , YES);
}

@end
