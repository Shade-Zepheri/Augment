#import "Interfaces.h"

@interface POPContentView : UIView {
    _UIBackdropView* _dimView;
    UIView* _keyWindow;
}
@property (nonatomic, retain) UIView* contextHostView;
-(id)initWithFrame:(CGRect)frame contextHostView:(UIView*)contextHostView;
-(void)fadeDimIn;
@end
