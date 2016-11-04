#import "Interfaces.h"
#import "AugWindow.h"
#import "CDTContextHostProvider.h"

@interface AugMent : NSObject
@property (nonatomic, retain) CDTContextHostProvider *contextHostProvider;
//@property (nonatomic, retain) NSMutableDictionary *windows;
@property (nonatomic, readwrite) NSInteger stackedWindowLevel;
+ (id)sharedInstance;
- (void)beginWindowModeForTopApplication;
- (void)beginWindowModeForApplicationWithBundleID:(NSString *)bundleID;
- (id)topmostApplication;
@end
