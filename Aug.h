#define SETTINGSFILENEW "com.shade.augment"
#define PREFERENCES_CHANGED_NOTIFICATION "com.shade.augment/ReloadPrefs"

@interface PSMagnifyController

+(void)commitMagnifyMode:(id)arg1 ;

@end

@interface PSMagnifyMode

+(id)magnifyModeWithSize:(CGSize)arg1 name:(id)arg2 localizedName:(id)arg3 isZoomed:(BOOL)arg4 ;

@end
