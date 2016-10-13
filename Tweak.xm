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

%hook PSMagnifyController

- (void)commitMagnifyMode:(id)arg1 {
  if(!enabled){
    %orig();
  }else{
    arg1 = [PSMagnifyMode magnifyModeWithSize:size name:@"" localizedName:@"" isZoomed:1];
    %orig(arg1);
  }
}

%end

//WAS JUST A TEST, NOT ACTUALLY PART OF TWEAK
%hook SBLockScreenViewController
- (void)finishUIUnlockFromSource:(int)arg1 {
  %orig();
  if (enabled) {
      UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Unlock"
                               message:hue
                               preferredStyle:UIAlertControllerStyleAlert];

      UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
         handler:^(UIAlertAction * action) {}];

      [alert addAction:defaultAction];
      [self presentViewController:alert animated:YES completion:nil];
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
