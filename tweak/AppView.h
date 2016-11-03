#import "Interfaces.h"

@interface AppView : UIView {
  UIView* _keyWindow;
}
@property (nonatomic, strong) UIView* contextHostView;
-(id)initWithFrame:(CGRect)frame contextHostView:(UIView*)contextHostView;
@end
