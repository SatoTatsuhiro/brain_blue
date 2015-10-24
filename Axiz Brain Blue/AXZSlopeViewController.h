#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface AXZSlopeViewController : UIViewController

@property CMMotionManager *SlopeRiderManager;

@property (weak, nonatomic) IBOutlet UIImageView *SlopeRider;

@end
