#import <UIKit/UIKit.h>

@interface AXZTripViewController : UIViewController

@property (strong,nonatomic) NSUserDefaults* tripUserDefaults;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel1;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel2;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel3;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel4;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel5;
@property (strong, nonatomic) IBOutlet UILabel *tripLabel6;

- (IBAction)backToMainViewAction:(id)sender;

@end
