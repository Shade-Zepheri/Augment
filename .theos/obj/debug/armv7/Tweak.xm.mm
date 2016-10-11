#line 1 "Tweak.xm"
#import "Aug.h"
NSString *hue;


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

@class PSMagnifyController; 
static void (*_logos_orig$_ungrouped$PSMagnifyController$commitMagnifyMode$)(_LOGOS_SELF_TYPE_NORMAL PSMagnifyController* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$PSMagnifyController$commitMagnifyMode$(_LOGOS_SELF_TYPE_NORMAL PSMagnifyController* _LOGOS_SELF_CONST, SEL, id); 

#line 4 "Tweak.xm"


static void _logos_method$_ungrouped$PSMagnifyController$commitMagnifyMode$(_LOGOS_SELF_TYPE_NORMAL PSMagnifyController* _LOGOS_SELF_CONST self, SEL _cmd, id arg1) {
	arg1 = [PSMagnifyMode magnifyModeWithSize:{width:750,height:1334} name:@"" localizedName:@"" isZoomed:1]];
	_logos_orig$_ungrouped$PSMagnifyController$commitMagnifyMode$(self, _cmd, arg1);
}


static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$PSMagnifyController = objc_getClass("PSMagnifyController"); if (_logos_class$_ungrouped$PSMagnifyController) {MSHookMessageEx(_logos_class$_ungrouped$PSMagnifyController, @selector(commitMagnifyMode:), (IMP)&_logos_method$_ungrouped$PSMagnifyController$commitMagnifyMode$, (IMP*)&_logos_orig$_ungrouped$PSMagnifyController$commitMagnifyMode$);} else {HBLogError(@"logos: nil class %s", "PSMagnifyController");}} }
#line 12 "Tweak.xm"
