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

%hook PSMagnifyMode

-(CGSize)size {
  return CGSizeMake(width, height);
  size = self;
}

-(NSString *)name {
  return @"";
  name = self;
}

-(NSString *)localizedName {
  return @"";
  localizedName = self;
}

-(BOOL)isZoomed {
  return 1;
  isZoomed = self;
}

%end

%ctor {
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
