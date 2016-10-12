#import "Aug.h"

static BOOL enabled = NO;
static CGSize six = {750,1334};
static CGFloat height = six.height;
static NSString *hue = [NSString stringWithFormat: @"%.2f", height];


%hook SBLockScreenViewController
- (void)finishUIUnlockFromSource:(int)arg1 {
  %orig();
  if (enabled) {
      UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unlock" message:hue delegate:nil cancelButtonTitle:@"OK :)" otherButtonTitles:nil, nil];
      [alertView show];
  }
}
%end
