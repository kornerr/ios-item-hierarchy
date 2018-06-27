// Topic: UIView Hide/Show with animation
// Source: https://stackoverflow.com/a/27647091

#import <UIKit/UIKit.h>

@interface UIView (Visibility) <CAAnimationDelegate>

- (BOOL)visible;
- (void)setVisible:(BOOL)visible;
- (void)setVisible:(BOOL)visible animated:(BOOL)animated;

@end
