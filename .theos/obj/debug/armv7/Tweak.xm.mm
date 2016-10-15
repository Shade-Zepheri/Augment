#line 1 "Tweak.xm"
#import "Aug.h"

CGSize *size;
NSString *name;
NSString *localizedName;
BOOL *isZoomed;

static BOOL enabled;
static CGFloat width = 750;
static CGFloat height = 1334;
static NSString *hue = [NSString stringWithFormat: @"%.2f,%.2f", width, height];

static void loadPrefs() {
  CFPreferencesAppSynchronize(CFSTR(SETTINGSFILENEW));
  enabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR(SETTINGSFILENEW)) ? NO : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR(SETTINGSFILENEW))) boolValue];
}

void applySettings() {
  [PSMagnifyController commitMagnifyMode:[PSMagnifyMode magnifyModeWithSize:size name:name localizedName:localizedNamename isZoomed:isZoomed]];
}


#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class PSMagnifyMode; 
static CGSize (*_logos_orig$_ungrouped$PSMagnifyMode$size)(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); static CGSize _logos_method$_ungrouped$PSMagnifyMode$size(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_orig$_ungrouped$PSMagnifyMode$name)(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$PSMagnifyMode$name(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); static NSString * (*_logos_orig$_ungrouped$PSMagnifyMode$localizedName)(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); static NSString * _logos_method$_ungrouped$PSMagnifyMode$localizedName(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); static BOOL (*_logos_orig$_ungrouped$PSMagnifyMode$isZoomed)(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); static BOOL _logos_method$_ungrouped$PSMagnifyMode$isZoomed(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST, SEL); 

#line 22 "Tweak.xm"


static CGSize _logos_method$_ungrouped$PSMagnifyMode$size(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST self, SEL _cmd) {
  return CGSizeMake(width, height);
  size = self;
}

static NSString * _logos_method$_ungrouped$PSMagnifyMode$name(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST self, SEL _cmd) {
  return @"";
  name = self;
}

static NSString * _logos_method$_ungrouped$PSMagnifyMode$localizedName(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST self, SEL _cmd) {
  return @"";
  localizedName = self;
}

static BOOL _logos_method$_ungrouped$PSMagnifyMode$isZoomed(_LOGOS_SELF_TYPE_NORMAL PSMagnifyMode* _LOGOS_SELF_CONST self, SEL _cmd) {
  return 1;
  isZoomed = self;
}



static __attribute__((constructor)) void _logosLocalCtor_9e60c2ca(int argc, char **argv, char **envp) {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadPrefs,
                                    CFSTR(PREFERENCES_CHANGED_NOTIFICATION),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);
  CFNotificationCenterAddObserver (CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)applySettings,
                                    CFSTR(APPLY),
                                    NULL,
                                    0);
	loadPrefs();
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$PSMagnifyMode = objc_getClass("PSMagnifyMode"); if (_logos_class$_ungrouped$PSMagnifyMode) {MSHookMessageEx(_logos_class$_ungrouped$PSMagnifyMode, @selector(size), (IMP)&_logos_method$_ungrouped$PSMagnifyMode$size, (IMP*)&_logos_orig$_ungrouped$PSMagnifyMode$size);} else {HBLogError(@"logos: nil class %s", "PSMagnifyMode");}if (_logos_class$_ungrouped$PSMagnifyMode) {MSHookMessageEx(_logos_class$_ungrouped$PSMagnifyMode, @selector(name), (IMP)&_logos_method$_ungrouped$PSMagnifyMode$name, (IMP*)&_logos_orig$_ungrouped$PSMagnifyMode$name);} else {HBLogError(@"logos: nil class %s", "PSMagnifyMode");}if (_logos_class$_ungrouped$PSMagnifyMode) {MSHookMessageEx(_logos_class$_ungrouped$PSMagnifyMode, @selector(localizedName), (IMP)&_logos_method$_ungrouped$PSMagnifyMode$localizedName, (IMP*)&_logos_orig$_ungrouped$PSMagnifyMode$localizedName);} else {HBLogError(@"logos: nil class %s", "PSMagnifyMode");}if (_logos_class$_ungrouped$PSMagnifyMode) {MSHookMessageEx(_logos_class$_ungrouped$PSMagnifyMode, @selector(isZoomed), (IMP)&_logos_method$_ungrouped$PSMagnifyMode$isZoomed, (IMP*)&_logos_orig$_ungrouped$PSMagnifyMode$isZoomed);} else {HBLogError(@"logos: nil class %s", "PSMagnifyMode");}} }
#line 61 "Tweak.xm"
