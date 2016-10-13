#import "Aug.h"

static BOOL enabled = NO;
static CGFloat width = 750;
static CGFloat height = 1334;
static CGSize size = CGSizeMake(width, height);
static NSString *hue = [NSString stringWithFormat: @"%.2f,%.2f", width, height];

%hook PSMagnifyController

//+(void)commitMagnifyMode:(id)arg1 {
  //arg1 = [PSMagnifyMode magnifyModeWithSize:size name:@"" localizedName:@"" isZoomed:1];
//}

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
