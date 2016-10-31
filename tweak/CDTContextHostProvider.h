// Credits: Phillip Tennen from Popcorn
#import "Interfaces.h"

@interface CDTContextHostProvider : NSObject

@property (nonatomic, retain) NSMutableArray *onlyIpad_runningIdentifiers;

- (UIView *)hostViewForApplication:(id)sbapplication;
- (UIView *)hostViewForApplicationWithBundleID:(NSString *)bundleID;
- (void)launchSuspendedApplicationWithBundleID:(NSString *)bundleID;
- (void)disableBackgroundingForApplication:(id)sbapplication;
- (void)enableBackgroundingForApplication:(id)sbapplication;
- (FBScene *)FBSceneForApplication:(id)sbapplication;
- (FBSceneHostManager *)contextManagerForApplication:(id)sbapplication;
- (FBSMutableSceneSettings *)sceneSettingsForApplication:(id)sbapplication;
- (BOOL)isHostViewHosting:(UIView *)hostView;
- (void)forceRehostingOnBundleID:(NSString *)bundleID;
- (void)stopHostingForBundleID:(NSString *)bundleID;
- (void)sendLandscapeRotationNotificationToBundleID:(NSString *)bundleID;
- (void)sendPortraitRotationNotificationToBundleID:(NSString *)bundleID;
- (void)setStatusBarHidden:(NSNumber *)hidden onApplicationWithBundleID:(NSString *)bundleID;

@end
