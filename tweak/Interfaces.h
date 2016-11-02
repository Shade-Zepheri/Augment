#define __is__iOS9__ [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

@interface FBSceneHostManager : NSObject
- (void)enableHostingForRequester:(id)arg1 orderFront:(BOOL)arg2;
- (void)enableHostingForRequester:(id)arg1 priority:(int)arg2;
- (void)disableHostingForRequester:(id)arg1;
- (id)hostViewForRequester:(id)arg1 enableAndOrderFront:(BOOL)arg2;
@end

@interface UIApplication (Private)
- (id)_accessibilityFrontMostApplication;
- (void)launchApplicationWithIdentifier: (NSString*)identifier suspended: (BOOL)suspended;
- (id)displayIdentifier;
- (void)setStatusBarHidden:(bool)arg1 animated:(bool)arg2;
void receivedStatusBarChange(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo);
void receivedLandscapeRotate();
void receivedPortraitRotate();
@end

@interface FBSceneHostWrapperView : UIView
- (BOOL)isHosting;
@end

@interface FBSMutableSceneSettings
- (void)setBackgrounded:(bool)arg1;
@end

@interface FBScene
- (id)contextHostManager;
- (id)mutableSettings;
-(void)_applyMutableSettings:(id)arg1 withTransitionContext:(id)arg2 completion:(id)arg3;
@end

@interface FBWindowContextHostView : UIView
- (BOOL)isHosting;
@end

@interface SBApplicationController
+ (id)sharedInstance;
- (id)applicationWithBundleIdentifier:(NSString *)bid;
@end

@interface SBApplication : NSObject
- (BOOL)statusBarHidden;
- (id)bundleIdentifier;
- (id)mainScene;
@end
