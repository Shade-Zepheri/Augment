#import "Aug.h"
NSString *hue;

%hook PSMagnifyController

-(void)commitMagnifyMode:(id)arg1 {
	arg1 = [PSMagnifyMode magnifyModeWithSize:{width:750,height:1334} name:@"" localizedName:@"" isZoomed:1]];
	%orig(arg1);
}

%end
