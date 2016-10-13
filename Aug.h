#import <objc/runtime.h>
#define SETTINGSFILENEW "com.shade.augment"
#define PREFERENCES_CHANGED_NOTIFICATION "com.shade.augment/ReloadPrefs"
#define RESPRING "com.shade.augment/Respring"

@interface PSMagnifyController

+(void)commitMagnifyMode:(id)arg1 ;

@end

@interface PSMagnifyMode

+(id)magnifyModeWithSize:(CGSize)arg1 name:(id)arg2 localizedName:(id)arg3 isZoomed:(BOOL)arg4 ;

@end

@interface FBSystemService : NSObject

- (id)sharedInstance;
- (void)exitAndRelaunch:(bool)arg1;

@end
