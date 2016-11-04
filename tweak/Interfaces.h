#define __is__iOS9__ [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0
CFNotificationCenterRef CFNotificationCenterGetDistributedCenter(void);

@interface SBRootFolderController : NSObject
@property (nonatomic, retain) UIView* contentView;
@end

@interface SBIconController : NSObject
+ (id)sharedInstance;
- (SBRootFolderController*)_rootFolderController;
- (SBRootFolderController*)_currentFolderController;
@end

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

@interface FBWindowContextHostManager : FBSceneHostManager
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

@interface SBDeactivationSettings
-(id)init;
-(void)setFlag:(int)flag forDeactivationSetting:(unsigned)deactivationSetting;
@end
@interface SBWorkspaceApplicationTransitionContext : NSObject
@property(nonatomic) _Bool animationDisabled; // @synthesize animationDisabled=_animationDisabled;
- (void)setEntity:(id)arg1 forLayoutRole:(int)arg2;
@end
@interface SBWorkspaceDeactivatingEntity
@property(nonatomic) long long layoutRole; // @synthesize layoutRole=_layoutRole;
+ (id)entity;
@end
@interface SBWorkspaceHomeScreenEntity : NSObject
@end
@interface SBMainWorkspaceTransitionRequest : NSObject
- (id)initWithDisplay:(id)arg1;
@end
@interface SBAppToAppWorkspaceTransaction
- (void)begin;
- (id)initWithAlertManager:(id)alertManager exitedApp:(id)app;
- (id)initWithAlertManager:(id)arg1 from:(id)arg2 to:(id)arg3 withResult:(id)arg4;
- (id)initWithTransitionRequest:(id)arg1;
@end
