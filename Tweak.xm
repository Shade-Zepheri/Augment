#import "Aug.h"

static BOOL enabled;
static CGFloat width = 750;
static CGFloat height = 1334;
static CGSize size = CGSizeMake(width, height);
static NSString *hue = [NSString stringWithFormat: @"%.2f,%.2f", width, height];

static void loadPrefs() {
  CFPreferencesAppSynchronize(CFSTR(SETTINGSFILENEW));
  enabled = !CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR(SETTINGSFILENEW)) ? NO : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("enabled"), CFSTR(SETTINGSFILENEW))) boolValue];
}
%hook PSMagnifyMode

-(void)setSize:(CGSize)arg1 {
  HBLogDebug(@"Ths method was run");
  %orig();
}

-(void)setName:(NSString *)arg1 {
  HBLogDebug(@"Ths method was run");
  %orig();
}

-(void)setLocalizedName:(NSString *)arg1 {
  HBLogDebug(@"Ths method was run");
  %orig();

}

-(void)setZoomed:(BOOL)arg1 {
  HBLogDebug(@"Ths method was run");
  %orig();

}

%end

%hook PSMagnifyController

- (void)commitMagnifyMode:(id)arg1 {
  HBLogDebug(@"Ths method was run");
  if(!enabled){
    %orig();
  }else{
    arg1 = [PSMagnifyMode magnifyModeWithSize:size name:@"" localizedName:@"" isZoomed:1];
    %orig(arg1);
  }
}

%end

%ctor {
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    NULL,
                                    (CFNotificationCallback)loadPrefs,
                                    CFSTR(PREFERENCES_CHANGED_NOTIFICATION),
                                    NULL,
                                    CFNotificationSuspensionBehaviorCoalesce);
	loadPrefs();
}
