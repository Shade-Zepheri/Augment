#import "CDTContextHostProvider.h"
#import "Interfaces.h"
#import "AppWindow.h"

@interface AugMent : NSObject

@property (nonatomic, retain) CDTContextHostProvider *contextHostProvider;
@property (nonatomic, retain) NSMutableDictionary *windows;
@property (nonatomic, readwrite) NSInteger stackedWindowLevel;

+ (id)sharedInstance;

@end
