#import "CDTContextHostProvider.h"

@implementation CDTContextHostProvider

- (id)init{
	if (self = [super init]) {
	}
	return self;
}

- (UIView *)hostViewForApplication:(id)sbapplication{

	[self enableBackgroundingForApplication:sbapplication];

	[self launchSuspendedApplicationWithBundleID:[(SBApplication *)sbapplication bundleIdentifier]];

	[[self contextManagerForApplication:sbapplication] enableHostingForRequester:[(SBApplication *)sbapplication bundleIdentifier] orderFront:YES];

	UIView *hostView = [[self contextManagerForApplication:sbapplication] _hostViewForRequester:[(SBApplication *)sbapplication bundleIdentifier] enableAndOrderFront:YES];
	return hostView;
}

- (UIView *)hostViewForApplicationWithBundleID:(NSString *)bundleID {

	SBApplication *appToHost = [[NSClassFromString(@"SBApplicationController") sharedInstance] applicationWithBundleIdentifier:bundleID];
	return [self hostViewForApplication:appToHost];
}

- (void)launchSuspendedApplicationWithBundleID:(NSString *)bundleID {
	[[UIApplication sharedApplication] launchApplicationWithIdentifier:bundleID suspended:YES];
}

- (void)disableBackgroundingForApplication:(id)sbapplication {

	FBSMutableSceneSettings *sceneSettings = [self sceneSettingsForApplication:sbapplication];

	[sceneSettings setBackgrounded:YES];

	[[self FBSceneForApplication:sbapplication] _applyMutableSettings:sceneSettings withTransitionContext:nil completion:nil];

}

- (void)enableBackgroundingForApplication:(id)sbapplication {

	FBSMutableSceneSettings *sceneSettings = [self sceneSettingsForApplication:sbapplication];

	[sceneSettings setBackgrounded:NO];

	[[self FBSceneForApplication:sbapplication] _applyMutableSettings:sceneSettings withTransitionContext:nil completion:nil];

}

- (FBScene *)FBSceneForApplication:(id)sbapplication {
  return [(SBApplication *)sbapplication mainScene];
}

- (FBSceneHostManager *)contextManagerForApplication:(id)sbapplication {
  return [[self FBSceneForApplication:sbapplication] contextHostManager];
}

- (FBSMutableSceneSettings *)sceneSettingsForApplication:(id)sbapplication {
	return [[[self FBSceneForApplication:sbapplication] mutableSettings] mutableCopy];
}

- (BOOL)isHostViewHosting:(UIView *)hostView {
  if (hostView && [[hostView subviews] count] >= 1)
      return [(FBSceneHostWrapperView *)[hostView subviews][0] isHosting];
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
  [self disableBackgroundingForApplication:appToHost];
  FBSceneHostManager *contextManager = [self contextManagerForApplication:appToHost];
	[contextManager disableHostingForRequester:bundleID];
}

- (void)sendLandscapeRotationNotificationToBundleID:(NSString *)bundleID {
	NSString *rotateNotification = [NSString stringWithFormat:@"%@LamoLandscapeRotate", bundleID];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)rotateNotification, NULL, NULL, YES);
}

- (void)sendPortraitRotationNotificationToBundleID:(NSString *)bundleID {
	NSString *rotateNotification = [NSString stringWithFormat:@"%@LamoPortraitRotate", bundleID];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)rotateNotification, NULL, NULL, YES);
}

- (void)setStatusBarHidden:(NSNumber *)hidden onApplicationWithBundleID:(NSString *)bundleID {
  NSString *changeStatusBarNotification = [NSString stringWithFormat:@"%@LamoStatusBarChange", bundleID];
  CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), (CFStringRef)changeStatusBarNotification, NULL, (__bridge CFDictionaryRef) @{@"isHidden" : hidden } , YES);
}

@end
