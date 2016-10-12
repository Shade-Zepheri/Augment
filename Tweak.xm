#import "Aug.h"

static BOOL enabled = NO;
static CGSize six = {750,1334};
static CGFloat height = six.height;
static NSString *hue = [NSString stringWithFormat: @"%.2f", height];

%hook PSMagnifyMode

+(id)magnifyModeWithSize:(CGSize)arg1 name:(id)arg2 localizedName:(id)arg3 isZoomed:(BOOL)arg4 ;

%end

%hook PSMagnifyController

+(void)commitMagnifyMode:(id)arg1 withRelaunchURL:(id)arg2 ;

%end

//WAS JUST A TEST, NOT ACTUALLY PART OF TWEAK
%hook SBLockScreenViewController
- (void)finishUIUnlockFromSource:(int)arg1 {
  %orig();
  if (enabled) {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unlock" message:hue delegate:nil cancelButtonTitle:@"OK :)" otherButtonTitles:nil, nil];
      [alertView show];
  }
}
%end
