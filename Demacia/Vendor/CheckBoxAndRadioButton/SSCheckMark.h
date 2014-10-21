#import <UIKit/UIKit.h>

typedef NS_ENUM( NSUInteger, SSCheckMarkStyle )
{
    SSCheckMarkStyleOpenCircle,
    SSCheckMarkStyleGrayedOut
};

@interface SSCheckMark : UIView

@property (readwrite, nonatomic) bool checked;
@property (readwrite, nonatomic) SSCheckMarkStyle checkMarkStyle;

@end